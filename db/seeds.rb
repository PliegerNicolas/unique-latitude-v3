# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# users = User.create([ # Default admin user for production
# {
#   username: "default_user",
#   email: "default_user@email.com",
#   password: "password",
#   password_confirmation: "password",
#   role: 2
# }
# ])

users = User.create([ # 3 Users
    {
      username: "user_1",
      email: "email1@example.com",
      password: "password",
      password_confirmation: "password",
      role: 2
    },
    {
      username: "user_2",
      email: "email2@example.com",
      password: "password",
      password_confirmation: "password",
      role: 1
    },
    {
      username: "user_3",
      email: "email3@example.com",
      password: "password",
      password_confirmation: "password",
      role: 0
    }
  ])

projects = Project.create([ # 4 Projects
  {
    title: "Project-Title-1",
    subject: "A subject",
    category: 0,
    user: User.last,
    status: 1
  },
  {
    title: "Project-Title-2",
    subject: "A subject 2",
    category: 1,
    user: User.last,
    status: 1
  },
  {
    title: "Project-Title-3",
    subject: "A subject 3",
    category: 2,
    user: User.last,
    status: 0
  },
  {
    title: "Project-Title-4",
    subject: "A subject 3",
    category: 2,
    user: User.first,
    status: 1
  }
])

media = Medium.create([ # 6 Documents
  {
    title: "Medium-Title-1",
    author: "Author-1",
    description: "Description.",
    location: "Somewhere",
    date: rand(1.year.ago..50.weeks.from_now).to_date,
    project: Project.find(1)
  },
  {
    title: "Medium-Title-2",
    author: "Author-2",
    description: "Description.",
    location: "Somewhere",
    date: rand(1.year.ago..50.weeks.from_now).to_date,
    project: Project.find(2)
  },
  {
    title: "Medium-Title-3",
    author: "Author-3",
    description: "Description.",
    location: "Somewhere",
    date: rand(1.year.ago..50.weeks.from_now).to_date,
    project: Project.find(3)
  },
  {
    title: "Medium-Title-4",
    author: "Author-4",
    description: "Description.",
    location: "Somewhere",
    date: rand(1.year.ago..50.weeks.from_now).to_date,
    project: Project.find(1)
  },
  {
    title: "Medium-Title-5",
    author: "Author-5",
    description: "Description.",
    location: "Somewhere",
    date: rand(1.year.ago..50.weeks.from_now).to_date,
    project: Project.find(1)
  },
  {
    title: "Doc-Title-6",
    author: "Author-6",
    description: "Description.",
    location: "Somewhere",
    date: rand(1.year.ago..50.weeks.from_now).to_date,
    project: Project.find(2)
  }
])