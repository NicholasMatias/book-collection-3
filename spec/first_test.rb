# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'validations' do
    it 'is valid with a title' do
      book = Book.new(title: 'Effective Testing')
      expect(book).to be_valid
    end

    it 'is invalid without a title' do
      book = Book.new(title: nil)
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end
  end
end

RSpec.describe 'Books Management', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows a user to add a new book successfully' do
    visit new_book_path
    fill_in 'Title', with: 'The Great Gatsby'
    click_button 'Create Book'
    expect(page).to have_content('Book was successfully created.')
    expect(page).to have_content('The Great Gatsby')
  end

  it 'shows an error when trying to add a book without a title' do
    visit new_book_path
    fill_in 'Title', with: ''
    click_button 'Create Book'
    expect(page).to have_content("Title can't be blank")
  end
end
