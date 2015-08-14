require 'spec_helper'

feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    user = build :user
  	expect { sign_up(user) }.to change(User, :count).by(1)
  	expect(page).to have_content("Welcome, #{user.email}")
  	expect(User.first.email).to eq("#{user.email}")
  end

  def sign_in_as(email: 'alice@example.com',
  			   password: 'oranges!',
           password_confirmation: 'oranges!')
  	visit '/users/new'
  	expect(page.status_code).to eq(200)
  	fill_in :email,     with: email
  	fill_in :password,  with: password
  	click_button 'Sign up'
  end

  scenario 'requires a matching confirmation password' do
    expect{ sign_in_as(password_confirmation: 'wrong') }.not_to change(User, :count)
  end

  def sign_up(user)
    visit '/users/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end

  scenario 'with a password that does not match' do
    expect { sign_in_as(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users') #current_path is a helper provided by Capybara
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'I can not sign in without an email' do 
    expect { sign_in_as(email: '')}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'I cannot sign up with an existing email' do
    user = build :user
    sign_up(user)
    expect{ sign_up(user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end

  # sign_in_as: bad guy
  # sign_up: good guy

end