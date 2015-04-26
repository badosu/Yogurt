unless env.production?
  DB[:communities].truncate
  DB[:users].truncate
end


Community.create name: "New Community",
                 description: "This is a nice community"

User.new(email: 'elduderino@lebowski.com',
         password: 'youropinionman').
     save(validate: false)
