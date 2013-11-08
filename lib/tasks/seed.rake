namespace :seed do
  desc 'sample users'
  task :users do
    User.create([
      { name: 'Shamim' },
      { name: 'Toby' },
      { name: 'Lachlan' }
    ])
  end
end
