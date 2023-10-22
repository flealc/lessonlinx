desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do

  
  if Rails.env.development?  
    pp "Wiping database..."
    Lesson.destroy_all
    Contact.destroy_all
    Student.destroy_all
    Calendar.destroy_all
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
    )
  User.create(
    email: "bob@example.com",
    password: "password",
    first_name: "Bob",
    last_name: Faker::Name.last_name,
  )
  p "There are now #{User.count} users"
  
  users = User.all

  users.each do |user|
   
    user.calendars.create(
      name: "Fall 2023"
    )
    
  end

  p "There are now #{Calendar.count} calendars"


  users.each do |user|
    n = user.first_name == "Alice" ? 10 : 5
    n.times do
      
      s = Student.create!(
        adult: [true, false].sample,                    
        first_name: Faker::Name.first_name,   
        last_name: Faker::Name.last_name,
        teacher_id: user.id
      )
    end
  end

  p "There are now #{Student.count} students"
  

  students = Student.all

  students.each do |student|
    starting_date = Faker::Time.backward(days: 20, period: [:afternoon, :morning].sample)
    10.times do
      
      student.lessons.create(
        lesson_notes: Faker::Lorem.paragraph(sentence_count: 5),
        starts_at: starting_date,
        ends_at: starting_date + [30, 45, 60].sample.minutes,
        status: starting_date < Date.current ? %w[taught canceled].sample : "scheduled",
        teacher_id: student.teacher_id,     
        calendar_id: student.teacher.calendars.sample.id
      )

      starting_date = starting_date + [7, 6, 8].sample.days
    end
    
  
    1..3.times do
      name = Faker::Name.first_name
      student.contacts.create(
        address: Faker::Address.full_address,
        email: "#{name.downcase}@example.com" ,
        first_name: name,
        last_name: Faker::Name.last_name,
        notes: Faker::Lorem.paragraph(sentence_count: 2..3),
        phone: Faker::PhoneNumber.cell_phone,
        preferred_communication_method: %w[ phone email ].sample,
        relationship: %w[ mother father self ].sample
      )
    end

    student.default_contact_id = student.contacts.sample.id
  end
  p "There are now #{Lesson.count} lessons"
  p "There are now #{Contact.count} contacts"

  
end
