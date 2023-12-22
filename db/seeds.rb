# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


=begin 
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

user = User.find_by(email: "test@lessonlinx.pro")

if user.present?
  user.students.create!([
    {
      first_name: 'Test',
      last_name: 'Student',
      date_of_birth: '1988-10-01',
      adult: true,
      lessons_count: 16,
      student_notes: 'This is a test, again, this is a test.',
    },
    {
      first_name: 'Brenna',
      last_name: 'Student',
      date_of_birth: '2001-03-13',
      adult: true,
      lessons_count: 7,
      student_notes: 'Brenna has been playing piano since she was 10. She likes slow classical pieces.',
    },
    {
      first_name: 'Joseph',
      last_name: 'Student',
      date_of_birth: '2010-07-03',
      adult: false,
      lessons_count: 14,
      student_notes: 'Plays both piano and flute. He is also great at origami!',
    },
  ])
  
  
  
  brenna = Student.find_by(first_name: "Brenna").id
  test = Student.find_by(first_name: "Test").id
  joseph = Student.find_by(first_name: "Joseph").id
  
  Lesson.create!([
    {
      starts_at: '2024-01-11T19:00:00.000Z',
      ends_at: '2024-01-11T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-06T18:30:00.000Z',
      ends_at: '2023-12-06T19:00:00.000Z',
      duration: 30,
      status: 'taught',
      lesson_notes: '<div>Brenna mastered Beethoven\'s <em>Sonata No. 404. </em>Next time, we will debug the allegro section.</div>',
      student_id: 'brenna',
      teacher_id: user.id
    },
    {
      starts_at: '2024-01-04T19:00:00.000Z',
      ends_at: '2024-01-04T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-29T21:00:00.000Z',
      ends_at: '2023-12-29T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-06T21:00:00.000Z',
      ends_at: '2023-12-06T21:30:00.000Z',
      duration: 30,
      status: 'taught',
      lesson_notes: '<div>Did a great job on the <em>\'Hello World\' Variations</em>. Each variation was as clear and fresh as a first output. Next time we\'ll try adding some custom functions.</div>',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-20T21:00:00.000Z',
      ends_at: '2023-12-20T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-20T18:30:00.000Z',
      ends_at: '2023-12-20T19:00:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'brenna',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-01T21:00:00.000Z',
      ends_at: '2023-12-01T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-04T21:00:00.000Z',
      ends_at: '2023-12-04T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-18T18:30:00.000Z',
      ends_at: '2023-12-18T19:00:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'brenna',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-21T19:00:00.000Z',
      ends_at: '2023-12-21T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-18T21:00:00.000Z',
      ends_at: '2023-12-18T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-11T18:30:00.000Z',
      ends_at: '2023-12-11T19:00:00.000Z',
      duration: 30,
      status: 'canceled',
      lesson_notes: '<div>Brenna experienced an Internal Server Error and we had to reschedule our lesson.</div>',
      student_id: 'brenna',
      teacher_id: user.id
    },
    {
      starts_at: '2024-01-01T21:00:00.000Z',
      ends_at: '2024-01-01T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-11-29T21:00:00.000Z',
      ends_at: '2023-11-29T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2024-01-09T19:00:00.000Z',
      ends_at: '2024-01-09T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-27T21:00:00.000Z',
      ends_at: '2023-12-27T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-13T18:30:00.000Z',
      ends_at: '2023-12-13T19:00:00.000Z',
      duration: 30,
      status: 'taught',
      lesson_notes: '<div>Brenna played Mozart\'s <em>Rondo Alla TurboLinks</em> with great speed and efficiency today. We will keep working on not refreshing the entire page—musically speaking.</div>',
      student_id: 'brenna',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-14T19:00:00.000Z',
      ends_at: '2023-12-14T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-05T19:00:00.000Z',
      ends_at: '2023-12-05T19:30:00.000Z',
      duration: 30,
      status: 'taught',
      lesson_notes: '<div>Joseph squashed all those bugs in \'Flight of the Bumblebee\' today. Next time, we will aim for even cleaner runs.</div>',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-28T19:00:00.000Z',
      ends_at: '2023-12-28T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-15T21:00:00.000Z',
      ends_at: '2023-12-15T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-11-28T19:00:00.000Z',
      ends_at: '2023-11-28T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-22T21:00:00.000Z',
      ends_at: '2023-12-22T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-26T19:00:00.000Z',
      ends_at: '2023-12-26T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-08T18:30:00.000Z',
      ends_at: '2023-12-08T19:00:00.000Z',
      duration: 30,
      status: 'taught',
      lesson_notes: '<div>Brenna is having a hard time handling exceptions smoothly in the Chopin Nocturne. I reminded her that every error is a learning opportunity!</div>',
      student_id: 'brenna',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-11T21:00:00.000Z',
      ends_at: '2023-12-11T21:30:00.000Z',
      duration: 30,
      status: 'taught',
      lesson_notes: '<div>Had some issues with the <em>"Middleware Mazurka". </em>It\'s all about the right timing and sequence. Next lesson, we will talk more about the request-response flow in the piece.</div>',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-08T21:00:00.000Z',
      ends_at: '2023-12-08T21:30:00.000Z',
      duration: 30,
      status: 'taught',
      lesson_notes: '<div>Had a hard time finding a break in the "<em>Infinite Loop Waltz". </em>Next time we will practice exit conditions.</div>',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-25T21:00:00.000Z',
      ends_at: '2023-12-25T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-13T21:00:00.000Z',
      ends_at: '2023-12-13T21:30:00.000Z',
      duration: 30,
      status: 'canceled',
      lesson_notes: '<div>Suffered a scheduling exception and had to error out of the lesson.</div>',
      student_id: 'test',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-19T19:00:00.000Z',
      ends_at: '2023-12-19T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2024-01-02T19:00:00.000Z',
      ends_at: '2024-01-02T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-15T18:30:00.000Z',
      ends_at: '2023-12-15T19:00:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'brenna',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-07T19:00:00.000Z',
      ends_at: '2023-12-07T19:30:00.000Z',
      duration: 30,
      status: 'taught',
      lesson_notes: '<div>Joseph asked to work on a lighter repertoire (closer to cocktail/piano bat music) for a while. I gave him a copy of <em>"If These Are Your Better Errors, I Don\'t Wanna See The Worst" </em>and he will work on it for next time.</div>',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-12-12T19:00:00.000Z',
      ends_at: '2023-12-12T19:30:00.000Z',
      duration: 30,
      status: 'taught',
      lesson_notes: '<div>Joseph is loving his new repertoire. For next time, he will try and make his mind about what to learn next. The choice is between <em>"Lost in Your Framework"</em> and<em> "Git Commit to Me, Baby".</em></div>',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2023-11-30T19:00:00.000Z',
      ends_at: '2023-11-30T19:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'joseph',
      teacher_id: user.id
    },
    {
      starts_at: '2024-01-03T21:00:00.000Z',
      ends_at: '2024-01-03T21:30:00.000Z',
      duration: 30,
      status: 'scheduled',
      lesson_notes: '',
      student_id: 'test',
      teacher_id: user.id
    },
  ])
  
end
=end
