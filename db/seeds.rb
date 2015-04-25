unless env.production?
  DB[:communities].truncate
end


Community.create name: "New Community",
                 description: "This is a nice community"
