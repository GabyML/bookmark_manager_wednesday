FactoryGirl.define do
	
	factory :user do # FactoryGirl will assume that the parent model of a factory named ":user" is "User".
	  email 'gabymayl@hotmail.com'
	  password '123omg'
	  password_confirmation '123omg'
	end

end