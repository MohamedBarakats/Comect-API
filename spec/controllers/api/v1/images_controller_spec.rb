# frozen_string_literal: true

require 'rails_helper'
require './spec/support/files_test_helper'
RSpec.describe Api::V1::ImagesController, type: :controller do
  let(:file) { FilesTestHelper.png }
  describe 'GET /index' do
    let(:image) { create :image, :with_file }
    it 'renders a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let!(:image) { create :image, :with_file }
    it 'renders a successful response' do
      get :show, params: { id: image.id }
      expect(response).to be_successful
      expect(JSON.parse(response.body).deep_symbolize_keys[:tag]).to eq(image.tag)
    end
  end

  describe 'POST /create' do
    let(:valid_params) do
      { image: { tag: 'vaild_tag', description: 'description', file: file } }
    end
    let(:invalid_params) do
      { image: { tag: 'vaild_tag', description: 'description' } }
    end
    def trigger
      post :create, params: valid_params
    end
    context 'with valid parameters' do
      it 'should upload the file' do
        expect { trigger }.to change { ActiveStorage::Attachment.count }.by(1)
      end
      it 'creates a new Image' do
        expect { trigger }.to change(Image, :count).by(1)
        image = Image.last
        expect(image.file).to be_attached
        expect(image.file.filename).to eq FilesTestHelper.png_name
        expect(image.tag).to eq 'vaild_tag'
      end

      it 'renders a JSON response with the new image' do
        trigger
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(JSON.parse(response.body).deep_symbolize_keys[:tag]).to eq('vaild_tag')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Image' do
        expect { post :create, params: invalid_params }.to change(Image, :count).by(0)
      end

      it 'renders a JSON response with errors for the new image' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(JSON.parse(response.body).deep_symbolize_keys).to eq({ file: ["can't be blank"] })
      end
    end
  end

  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) do
  #       skip('Add a hash of attributes valid for your model')
  #     end

  #     it 'updates the requested image' do
  #       image = Image.create! valid_attributes
  #       patch image_url(image),
  #             params: { image: invalid_attributes }, headers: valid_headers, as: :json
  #       image.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'renders a JSON response with the image' do
  #       image = Image.create! valid_attributes
  #       patch image_url(image),
  #             params: { image: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to eq('application/json')
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'renders a JSON response with errors for the image' do
  #       image = Image.create! valid_attributes
  #       patch image_url(image),
  #             params: { image: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to eq('application/json')
  #     end
  #   end
  # end

  describe 'DELETE /destroy' do
    let!(:image) { create :image, :with_file }
    def trigger
      delete :destroy, params: { id: image.id }
    end

    it 'destroys the requested image' do
      expect { trigger }.to change(Image, :count).by(-1)
    end
  end
end
