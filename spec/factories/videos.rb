Factory.define :video do |v|
  v.add_attribute :name, 'name'
  v.add_attribute :email, 'email'
  v.add_attribute :age, 'age'
  v.add_attribute :ethnicity, []
  v.add_attribute :language, 'language'
  v.add_attribute :location, 'location'
  v.add_attribute :why, 'why'
  v.add_attribute :how, 'how'
  v.add_attribute :hope, 'hope'
  v.add_attribute :qa, 'qa'
  v.add_attribute :status, 'pending'
  v.add_attribute :youtube_id, '1234'
  v.add_attribute :user_id, ''
end
