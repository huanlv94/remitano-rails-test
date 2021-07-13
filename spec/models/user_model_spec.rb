require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to have_fields(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_field(:encrypted_password) }
  it { is_expected.to have_fields(:remember_created_at).of_type(Time) }
end
