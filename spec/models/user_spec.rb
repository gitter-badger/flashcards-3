require 'rails_helper'

describe User do

  let (:user) { build(:user) }

  it "validates with email and password" do
    expect(user.valid?).to be true
  end
end
