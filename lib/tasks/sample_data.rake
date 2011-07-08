namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_posts
    make_relationships
  end
end
    
def make_users
  admin = User.create!(:name => "Example User",
                       :email => "example@railstutorial.org",
                       :location => "Boston, MA",
                       :tagline => "My tagline",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)         
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    location = Faker::Address.city
    tagline = "This is an awesome tagline"
    User.create!(:name => name,
                 :email => email,
                 :location => location,
                 :tagline => tagline,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_posts
  User.all(:limit => 6).each do |user|
    50.times do
      user.posts.create!(:content => Faker::Lorem.sentence(20), :posttype => "Review")
    end
  end
end

def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end


