desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do

  
  if Rails.env.development?  
    pp "Wiping database..."
    Lesson.destroy_all
    Contact.all.each do |contact|
      contact.student.default_contact_id = nil if contact.default?
      contact.student.save 
      contact.destroy
    end
    Student.destroy_all
    User.destroy_all
    p "Wiped database"
  end

  5.times do
    name = Faker::Name.first_name
    User.create(
      email: "#{name}@example.com",
      password: "password",
      first_name: name,
      last_name: Faker::Name.last_name,
    )
  end

  User.create(
      email: "alice@example.com",
      password: "password",
      first_name: "Alice",
      last_name: Faker::Name.last_name,
      timezone: "Central Time (US & Canada)"
    )
  User.create(
    email: "bob@example.com",
    password: "password",
    first_name: "Bob",
    last_name: Faker::Name.last_name,
    timezone: "Central Time (US & Canada)"
  )
  p "There are now #{User.count} users"
  
  users = User.all


  users.each do |user|
    n = user.first_name == "Alice" ? 10 : 5
    n.times do
    age_range = (4..65).to_a.sample
      s = Student.create!(                
        first_name: Faker::Name.first_name,   
        last_name: Faker::Name.last_name,
        teacher_id: user.id,
        student_notes: Faker::Lorem.paragraph(sentence_count: 3),
        age: age_range,
        adult: age_range > 17 ? true : false
      )
    end
  end

  p "There are now #{Student.count} students"
  

  students = Student.all

  students.each do |student|
    starting_date = Faker::Time.backward(days: 20, period: [:afternoon, :morning].sample)
    10.times do
      duration = [30, 45, 60].sample
      
      student.lessons.create(
        lesson_notes: Faker::Lorem.paragraph(sentence_count: 10),
        starts_at: starting_date,
        ends_at: starting_date + duration.minutes,
        duration: duration,
        status: starting_date < Date.current ? %w[taught canceled].sample : "scheduled",
        teacher_id: student.teacher_id,     
      )

      starting_date = starting_date + [7, 6, 8].sample.days
    end
    
    if student.adult? 
      student.contacts.create(
        first_name: student.first_name,
        last_name: student.last_name,
        address: Faker::Address.full_address,
        email: "#{student.first_name.downcase}@example.com" ,
        notes: Faker::Lorem.paragraph(sentence_count: 2..3),
        phone: Faker::PhoneNumber.cell_phone,
        preferred_communication_method: %w[ phone email ].sample,
        relationship: "self"
      )
    end

    2.times do
      relationship = %w[ mother father grandmother grandfather ].sample
      name = %w[ mother grandmother].include?(relationship) ? Faker::Name.female_first_name : Faker::Name.male_first_name
      student.contacts.create(
        address: Faker::Address.full_address,
        email: "#{name.downcase}@example.com" ,
        first_name: name,
        last_name: Faker::Name.last_name,
        notes: Faker::Lorem.paragraph(sentence_count: 2..3),
        phone: Faker::PhoneNumber.cell_phone,
        relationship: relationship,
        preferred_communication_method: %w[ phone email ].sample,
      )
    end

    student.default_contact_id = student.adult ? student.contacts.find_by(relationship: "self") : student.contacts.sample.id
    student.save

  end
  p "There are now #{Lesson.count} lessons"
  p "There are now #{Contact.count} contacts"

  
end
