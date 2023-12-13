# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


User.destroy_all

User.create(
  email: "fidelxleal@gmail.com",
  password: SecureRandom.hex(10),
  first_name: "Fidel",
  last_name: "Leal",
  timezone: "Central Time (US & Canada)",
  admin: true
)

User.create(
  email: "test@lessonlinx.pro",
  password: "s3cr3tp4ssw0rd",
  first_name: "Test",
  last_name: "User",
  timezone: "Central Time (US & Canada)",
  admin: false
)

User.all.each do |user|
  n.times do
    dob = Faker::Date.birthday(min_age: 4, max_age: 65)
    s = Student.create!(                
      first_name: Faker::Name.first_name,   
      last_name: Faker::Name.last_name,
      teacher_id: user.id,
      student_notes: Faker::Lorem.paragraph(sentence_count: 3),
      date_of_birth: dob, 
      adult: (Date.current - dob) > 17 ? true : false
    )
  end
end


students = Student.all

students.each do |student|
  starting_date = Faker::Time.backward(days: 20, period: [:afternoon, :morning].sample).change(sec: 00) # Needed to change seconds to 00 because of Safari datetime field validation bug
  10.times do
    duration = [30, 45, 60].sample
    
    student.lessons.create(
      lesson_notes: "<p>#{Faker::Lorem.paragraphs(number: 2).join('</p><p>')}</p>",
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
      contact_notes: Faker::Lorem.paragraph(sentence_count: 2..3),
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
      contact_notes: Faker::Lorem.paragraph(sentence_count: 2..3),
      phone: Faker::PhoneNumber.cell_phone,
      relationship: relationship,
      preferred_communication_method: %w[ phone email ].sample,
    )
  end

  student.default_contact_id = student.adult ? student.contacts.find_by(relationship: "self").id : student.contacts.sample.id
  student.save

end
