# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, type: :model do
  subject do
    described_class.new(tag: 'Anything',
                        description: 'Barakat',
                        file: FilesTestHelper.png)
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a tag' do
    subject.tag = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a description' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a start_date' do
    subject.file = nil
    expect(subject).to_not be_valid
  end
end
