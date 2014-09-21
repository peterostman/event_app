require 'spec_helper'

describe "A registration" do
    
  it "belongs to a movie" do
    event = Event.create(event_attributes)
    
    registration = event.registrations.new(registration_attributes)
        
    expect(registration.event).to eq(event)
  end
  
  it "requires a name" do
    registration = Registration.new(name: "")
    
    registration.valid? # populates errors
    
    expect(registration.errors[:name].any?).to eq(true)
  end

  it "requires an email" do
    registration = Registration.new(email: "")
    
    registration.valid?
    
    expect(registration.errors[:email].any?).to eq(true)
  end

  it "accepts properly formatted emails" do
    emails = %w[user@example.com USER@example.com first.last@example.com]
    emails.each do |email|
      registration = Registration.new(email: email)
      
      registration.valid?

      expect(registration.errors[:email].any?).to eq(false)
    end
  end
  
  it "reject improperly formatted emails" do
    emails = %w[user user_at_example.com @example.]
    emails.each do |email|
      registration = Registration.new(email: email)
      
      registration.valid?

      expect(registration.errors[:email].any?).to eq(true)
    end
  end
  
  it "accepts any how heard option that is in an approved list" do
    options = Registration::HOW_HEARD_OPTIONS
    options.each do |option|
      registration = Registration.new(how_heard: option)
      
      registration.valid?

      expect(registration.errors[:how_heard].any?).to eq(false)
    end
  end
  
  it "rejects any how heard option that is not in the approved list" do
    options = %w[foo bar baz]
    options.each do |option|
      registration = Registration.new(how_heard: option)
      
      registration.valid?

      expect(registration.errors[:how_heard].any?).to eq(true)
    end
  end
end

  # 
  # it "requires a description" do
  #   event = Event.new(description: "")
  #   
  #   event.valid?
  #
  #   expect(event.errors[:description].any?).to eq(true)
  # end
  # 
  # it "requires a location" do
  #   event = Event.new(location: "")
  #   
  #   event.valid?
  #
  #   expect(event.errors[:location].any?).to eq(true)
  # end
  # 
  # it "requires a description over 24 characters" do
  #   event = Event.new(description: "X" * 24)
  #   
  #   event.valid?
  #
  #   expect(event.errors[:description].any?).to eq(true)
  # end
  # 
  # it "accepts a $0 price" do
  #   event = Event.new(price: 0.00)
  # 
  #   event.valid?
  #
  #   expect(event.errors[:price].any?).to eq(false)
  # end
  # 
  # it "accepts a positive price" do
  #   event = Event.new(price: 10.00)
  # 
  #   event.valid?
  #
  #   expect(event.errors[:price].any?).to eq(false)
  # end
  # 
  # it "rejects a negative price" do
  #   event = Event.new(price: -10.00)
  # 
  #   event.valid?
  #
  #   expect(event.errors[:price].any?).to eq(true)
  # end
  # 
  # it "rejects a 0 capacity" do
  #   event = Event.new(capacity: 0)
  # 
  #   event.valid?
  #
  #   expect(event.errors[:capacity].any?).to eq(true)
  # end
  # 
  # it "accepts a positive capacity" do
  #   event = Event.new(capacity: 5)
  # 
  #   event.valid?
  #
  #   expect(event.errors[:capacity].any?).to eq(false)
  # end
  # 
  # it "rejects a negative capacity" do
  #   event = Event.new(capacity: -5)
  # 
  #   event.valid?
  #
  #   expect(event.errors[:capacity].any?).to eq(true)
  # end
  # 
  # it "rejects a non-integer capacity" do
  #   event = Event.new(capacity: 3.14159)
  # 
  #   event.valid?
  #
  #   expect(event.errors[:capacity].any?).to eq(true)
  # end
  # 
  # it "accepts properly formatted image file names" do
  #   file_names = %w[e.png event.png event.jpg event.gif EVENT.GIF]
  #   file_names.each do |file_name|
  #     event = Event.new(image_file_name: file_name)
  #     event.valid?
  #     expect(event.errors[:image_file_name].any?).to eq(false)
  #   end
  # end
  # 
  # it "reject improperly formatted image file names" do
  #   file_names = %w[event .jpg .png .gif event.pdf event.doc]
  #   file_names.each do |file_name|
  #     event = Event.new(image_file_name: file_name)
  #     event.valid?
  #     expect(event.errors[:image_file_name].any?).to eq(true)
  #   end
  # end
  # 
  # it "accepts prices that are multiples of fifty cents" do
  #   prices = [0.00, 1.00, 1.50]
  #   prices.each do |price|
  #     event = Event.new(price: price)
  #     event.valid?
  #     expect(event.errors[:price].any?).to eq(false)
  #   end
  # end
  # 
  # it "rejects prices that are not multiples of fifty cents" do
  #   prices = [1.10, 1.25, 1.75]
  #   prices.each do |price|
  #     event = Event.new(price: price)
  #     event.valid?
  #     expect(event.errors[:price].any?).to eq(true)
  #   end
  # end
  # 
  # it "with example attributes is valid" do
  #   event = Event.new(event_attributes)
  #   
  #   expect(event.valid?).to eq(true)
  # end
  # 