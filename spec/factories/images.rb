# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    tag { 'MyTag' }
    trend { 'MyTrebd' }
    description { 'MyText' }
    trait :with_file do
      file { FilesTestHelper.png }
    end
  end
end
