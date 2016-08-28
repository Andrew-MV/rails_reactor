require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  context 'response of #analyze should' do

    def params(dataset)
      {
          meta: {
              dataset: dataset
          }
      }
    end

    it 'fail due to empty dataset' do
      post :analyze, params(nil), format: :json
      expect(response).to be_bad_request
    end

    it 'fail due to invalid dataset' do
      post :analyze, params(''), format: :json
      expect(response).to be_bad_request
    end

    it 'fail due to invalid dataset' do
      post :analyze, params('1,2,g'), format: :json
      expect(response).to be_bad_request
    end

    context 'be successful due to valid dataset' do
      dataset1 = '  1 , 2 ,3, 4, 5, '
      dataset2 = '1,1,1,11,11,11,11,11,11,11,11,11,11,11'
      it 'and return correct q1' do
        post :analyze, params(dataset1), format: :json
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['meta']['q1']).to eq 1.5
      end
      it 'and return correct outliers' do
        post :analyze, params(dataset2), format: :json
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['meta']['outliers']).to eq '1; 1; 1'
      end
    end

  end

  context 'response of #correlate should' do

    def params(dataset1, dataset2)
      {
          meta: {
              dataset1: dataset1,
              dataset2: dataset2
          }
      }
    end

    it 'fail due to empty dataset' do
      post :correlate, params('2,3,4', nil), format: :json
      expect(response).to be_bad_request
    end

    it 'fail due to invalid dataset' do
      post :correlate, params('1,3,g', ' 5 ,6, 5 '), format: :json
      expect(response).to be_bad_request
    end

    it 'fail due to invalid dataset' do
      post :correlate, params('1,1,1', '2,3,4'), format: :json
      expect(response).to be_bad_request
    end

    it 'fail due to different size of arrays' do
      post :correlate, params('1,1,1,5', '2,3,4'), format: :json
      expect(response).to be_bad_request
    end

    context 'be successful due to valid datasets' do
      dataset1 = ['  1 , 2 ,3, 4, 5, ']
      dataset2 = ['1,2,3,7,11']
      it 'and return correct value' do
        post :correlate, params(dataset1[0], dataset2[0]), format: :json
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['meta']['answer']).to be_within(1).of(0)
      end
    end

  end

end