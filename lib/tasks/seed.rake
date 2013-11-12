namespace :seed do
  desc 'sample users'
  task :users do
    User.create([
      { name: 'Shamim' },
      { name: 'Brian' },
      { name: 'Andrew' }
    ])
  end

  task :sample_article do
    Article.create(
      title:    "The Hub: Open Source Conference Guidance",
      content:  "Conferences can be pretty daunting experiences. Multi-track1 monstrosities filled with new people, talks of unknown value and a slew of social events to choose between. Great conferences can even make it worse by having such an array of fantastic speakers that choosing which talks to attend becomes difficult. How do you make it better? How do you share an awesome conference with the outside world? We thought about it and we built The Hub.",
      author:   User.find_by_name('Andrew')
    )
  end
end
