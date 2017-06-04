rails new vueb --api

gem 'faker'

bundle

https://github.com/stympy/faker

id : integer
plot : string
writer : string
upvotes : integer

rails g scaffold story plot writer upvotes:integer

plot - lorem - Faker::Lorem.sentence
writer - name -  Faker::Name.name    
upvotes - number - Faker::Number.between(1, 200) 

seeds.rb:

100.times do
  Story.create(plot: Faker::Lorem.sentence, writer: Faker::Name.name, upvotes: Faker::Number.between(1, 200))
end

rails db:migrate

rails db:seed

You can now view the JSON : http://localhost:3000/stories



Pagination



gem 'active_model_serializers'  

bundle

Create config/initializers/active_model_serializers.rb:

ActiveModelSerializers.config.adapter = :json_api  

Add:

api_mime_types = %W(  
  application/vnd.api+json
  text/x-json
  application/json
)
Mime::Type.register 'application/vnd.api+json', :json, api_mime_types  

to the initializer.

rails g serializer
Usage:
  rails generate serializer NAME [field:type field:type] [options]

Options:
  [--skip-namespace], [--no-skip-namespace]  # Skip namespace (affects only isolated applications)
  [--parent=PARENT]                          # The parent class for the generated serializer

Runtime options:
  -f, [--force]                    # Overwrite files that already exist
  -p, [--pretend], [--no-pretend]  # Run but do not make any changes
  -q, [--quiet], [--no-quiet]      # Suppress status output
  -s, [--skip], [--no-skip]        # Skip files that already exist

Description:
    Generates a serializer for the given resource.

Example:
    `rails generate serializer Account name created_at`

rails g serializer stories -p


class StoriesSerializer < ActiveModel::Serializer
  attributes :id, :plot, :writer, :upvotes
  
end


No serializer found for resource: #<Story id: 3, plot: "This is the third record.", writer: "Maddy Wong", upvotes: 56, created_at: "2017-06-02 01:23:06", updated_at: "2017-06-02 07:10:48">
[active_model_serializers] Rendered ActiveModel::Serializer::CollectionSerializer with Story::ActiveRecord_Relation (24.65ms)
Completed 200 O

Rename serializer to story_serializer.rb and rename the class:

class StorySerializer < ActiveModel::Serializer


gem 'will_paginate'
gem 'api-pagination'

bundle

curl -I http://localhost:3000/stories
HTTP/1.1 200 OK
Link: <http://localhost:3000/stories?page=4>; rel="last", <http://localhost:3000/stories?page=2>; rel="next"
Per-Page: 30
Total: 103
Content-Type: application/json; charset=utf-8
ETag: W/"5ba579e6268a598b085567ea5c700470"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: 2e730f86-d83e-493f-939d-6e4f80cd4cb5
X-Runtime: 0.025491
Vary: Origin


http://localhost:3000/stories?page[number]=2&page[size]=30&page_number=2

links: {
self: "http://localhost:3000/stories?page%5Bnumber%5D=1&page%5Bsize%5D=30&page_number=2",
next: "http://localhost:3000/stories?page%5Bnumber%5D=2&page%5Bsize%5D=30&page_number=2",
last: "http://localhost:3000/stories?page%5Bnumber%5D=4&page%5Bsize%5D=30&page_number=2"
}

There is no previous link.

gem 'pager_api'

bundle

rails g pager_api:install

Change the controller: 

paginate @stories, per_page: 10

NoMethodError (undefined method `per' for #<Story::ActiveRecord_Relation:0x007fa50c415560>):


can't convert ActionController::Parameters into Integer rails


links": {
    "self": "http://example.com/articles",
    "next": "http://example.com/articles?page[offset]=2",
    "last": "http://example.com/articles?page[offset]=10"
  },
  "data": [{
    

Started GET "/stories?page[offset]=2" for 127.0.0.1 at 2017-06-03 20:25:35 -0700
Processing by StoriesController#index as HTML
  Parameters: {"page"=>{"offset"=>"2"}}
Completed 500 Internal Server Error in 0ms (ActiveRecord: 0.0ms)


  
TypeError (can't convert ActionController::Parameters into Integer):
  
app/controllers/stories_controller.rb:6:in `index'


http://localhost:3000/stories?page[offset]=2


stories = Story.paginate(page: params[:page][:offset], per_page: 10)      


links: {
self: "http://localhost:3000/stories?page%5Bnumber%5D=2&page%5Bsize%5D=10",
first: "http://localhost:3000/stories?page%5Bnumber%5D=1&page%5Bsize%5D=10",
prev: "http://localhost:3000/stories?page%5Bnumber%5D=1&page%5Bsize%5D=10",
next: "http://localhost:3000/stories?page%5Bnumber%5D=3&page%5Bsize%5D=10",
last: "http://localhost:3000/stories?page%5Bnumber%5D=11&page%5Bsize%5D=10"
}





http://www.thegreatcodeadventure.com/building-a-super-simple-rails-api-json-api-edition-2/
https://thesocietea.org/2017/02/building-a-json-api-with-rails-part-6-the-json-api-spec-pagination-and-versioning/

