# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'validations' do
    it 'is valid with all required attributes' do
      book = Book.new(
        title: 'Effective Testing',
        author: 'John Doe',
        price: 19.99,
        published_date: '2024-01-01'
      )
      expect(book).to be_valid
    end

    it 'is invalid without a title' do
      book = Book.new(
        title: nil,
        author: 'John Doe',
        price: 19.99,
        published_date: '2024-01-01'
      )
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without an author' do
      book = Book.new(
        title: 'Effective Testing',
        author: nil,
        price: 19.99,
        published_date: '2024-01-01'
      )
      expect(book).not_to be_valid
      expect(book.errors[:author]).to include("can't be blank")
    end

    it 'is invalid without a price' do
      book = Book.new(
        title: 'Effective Testing',
        author: 'John Doe',
        price: nil,
        published_date: '2024-01-01'
      )
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include("can't be blank")
    end

    it 'is invalid without a published date' do
      book = Book.new(
        title: 'Effective Testing',
        author: 'John Doe',
        price: 19.99,
        published_date: nil
      )
      expect(book).not_to be_valid
      expect(book.errors[:published_date]).to include("can't be blank")
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
    fill_in 'Author', with: 'F. Scott Fitzgerald'
    fill_in 'Price', with: 10.99
    fill_in 'Published Date', with: '1925-04-10'
    click_button 'Create Book'
    expect(page).to have_content('Book was successfully created.')
    expect(page).to have_content('The Great Gatsby')
    expect(page).to have_content('F. Scott Fitzgerald')
    expect(page).to have_content('10.99')
    expect(page).to have_content('1925-04-10')
  end

  it 'shows an error when trying to add a book without a title' do
    visit new_book_path
    fill_in 'Title', with: ''
    fill_in 'Author', with: 'John Doe'
    fill_in 'Price', with: 19.99
    fill_in 'Published Date', with: '2024-01-01'
    click_button 'Create Book'
    expect(page).to have_content("Title can't be blank")
  end

  it 'shows an error when trying to add a book without an author' do
    visit new_book_path
    fill_in 'Title', with: 'Effective Testing'
    fill_in 'Author', with: ''
    fill_in 'Price', with: 19.99
    fill_in 'Published Date', with: '2024-01-01'
    click_button 'Create Book'
    expect(page).to have_content("Author can't be blank")
  end

  it 'shows an error when trying to add a book without a price' do
    visit new_book_path
    fill_in 'Title', with: 'Effective Testing'
    fill_in 'Author', with: 'John Doe'
    fill_in 'Price', with: ''
    fill_in 'Published Date', with: '2024-01-01'
    click_button 'Create Book'
    expect(page).to have_content("Price can't be blank")
  end

  it 'shows an error when trying to add a book without a published date' do
    visit new_book_path
    fill_in 'Title', with: 'Effective Testing'
    fill_in 'Author', with: 'John Doe'
    fill_in 'Price', with: 19.99
    fill_in 'Published Date', with: ''
    click_button 'Create Book'
    expect(page).to have_content("Published date can't be blank")
  end
end
