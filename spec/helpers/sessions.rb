module SessionsHelpers

	def sign_in_as(email: 'alice@example.com', password: 'oranges!', password_confirmation: 'oranges!')
		visit '/users/new'
		expect(page.status_code).to eq(200)
		fill_in :email,     with: email
		fill_in :password,  with: password
		click_button 'Sign up'
	end

   def sign_up(user)
   	visit '/users/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
    end

end