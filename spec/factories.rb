Factory.define :user do |user|
	user.name                  'example user'
	user.email                 'example@email.com'
	user.password              '12345678'
	user.password_confirmation '12345678'
end