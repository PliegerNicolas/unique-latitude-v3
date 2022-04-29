# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.create([
    {
      username: "user",
      email: "email1@example.com",
      password: "password",
      password_confirmation: "password",
      role: 0
    },
    {
      username: "admin",
      email: "email2@example.com",
      password: "password",
      password_confirmation: "password",
      role: 2
    }
  ])

projects = Project.create([
  {
    title: "Project-Title-1",
    subject: "A subject",
    category: 0,
    user: User.last,
    published: "published"
  },
  {
    title: "Project-Title-2",
    subject: "A subject 2",
    category: 1,
    user: User.last,
    published: "published"
  },
  {
    title: "Project-Title-3",
    subject: "A subject 3",
    category: 2,
    user: User.last,
    published: "unpublished"
  },
  {
    title: "Project-Title-4",
    subject: "A subject 3",
    category: 2,
    user: User.first,
    published: "published"
  }
])

visual_media = VisualMedium.create([
  {
    title: "VM-Title-1",
    url: "http://www.rand-link-1.com",
    media: 0,
    project: Project.first
  },
  {
    title: "VM-Title-2",
    url: "http://www.rand-link-2.com",
    media: 1,
    project: Project.first
  },
  {
    title: "VM-Title-3",
    url: "http://www.rand-link-3.com",
    media: 1,
    project: Project.last
  }
])