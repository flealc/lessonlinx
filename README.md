# LessonLinx

Keeping track of student info, lesson notes, and scheduling can be challenging for an independent instructor, especially as the number of students increases. There is currently a need for a unified solution — a tool that enables users to easily manage lesson notes, organize contact details, gain insights into each student's progress, and subscribe to a teaching calendar, all while securely storing data in a single and accessible location.

Designed with independent instructors and tutors in mind, **LessonLinx** allows users to manage students' contact information and lesson schedules to facilitate the organization of their teaching activities.

## Key Features

**LessonLinx** users can:

- Register for an account to enter and manage their teaching information.
- Access a dashboard that provides an overview of the lessons scheduled for the current week, along with notes from previous lessons.
- Create, edit, and delete student information and contact details to maintain accurate and up-to-date records.
- Create, edit, and delete lessons to manage their teaching schedule effectively, including batch-scheduling and deleting lessons to efficiently manage recurring appointments and accommodate semester-based programs.
- Subscribe to a teaching calendar on their personal device, featuring calendar events that include notes from the previous lessons and contact information for each specific appointment.
- Sign up to receive a daily email digest of their agenda on days when lessons are scheduled, so they can stay organized and prepared.


## Getting Started

### Dependencies

LessonLinx uses a PostgreSQL database. Instructions for installing and running PostgreSQL locally are available [here](https://www.prisma.io/dataguide/postgresql/setting-up-a-local-postgresql-database).

LessonLinx also relies on GoodJob and Postmart for email delivery and job scheduling, and Devise and Pundit for user authentication and authorization.



### Installing

1. Clone the main branch of this repository into your local development environment: `git clone git@github.com:fidel-techprep/lessonlinx.git`
2. Create a database: `rake db:create`
3. Run the database migrations: `rake db:migrate`
4. (Optional) Add sample data: `rake sample_data`. The script sets up a series of test users, including `alice@example.com`, with password `password`.
5. You can use the rails console (`rails c`) to manually give admin privileges to a user (i.e. `user.admin = true`, and then `user.save!`).

### Executing program

You can start the development server by running `rails s`.

## Authors

Fidel Leal
[fidelxleal@gmail.com](mailto:fidelxleal@gmail.com)


## Acknowledgments

Special thanks to [Ian Heraty](@heratyian) and the amazing team at Discovery Partners Institute for their guidance and support.
