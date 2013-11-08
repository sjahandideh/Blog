require "spec_helper"

feature "Managing Articles", js: true, demo: true do
  before :each do
    Capybara.default_wait_time = 80
  end

  scenario "Adding a new article" do
    rake 'seed:users'
    User.count.should == 3

    demo_step "visiting articles"
    visit '/articles'

    demo_step "creating a new article"
    click_on  'New Article'
    fill_in   'article_title',    with: "Meet Brutus, the Ninefold Yak"
    fill_in   'article_content',  with: "As he doesn't like to be shaved (see his pitiful little face) we're always trying to make Ninefold super-easy to deploy Rails apps on. One of the first features we rolled out was post-commit hooks that allows you to auto deploy your app from the one source of Git truth. We've had support for GitHub since day dot and today we are proud to announce that we've implemented it for BitBucket too. In fact, we've added Git URL support as well so you can hook into your private repo or whatever your favorite flavor is: Codaset, GitServer, Assembla, GitLab etc."
    select    'Shamim',           from: 'article_author_id'

    click_on 'Create Article'

    demo_step "viewing the created article"
    page.should have_content "Article was successfully created."
  end
end
