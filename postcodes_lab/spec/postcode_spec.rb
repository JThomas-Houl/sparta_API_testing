require 'spec_helper'

describe Postcodesio do

  context 'requesting information on a single postcode works correctly' do

    before(:all) do
      @postcodesio = Postcodesio.new
      @response = @postcodesio.get_single_postcode('b601ja') #input a postcode
      @UK_contries_array = [ 'England', 'Northern Ireland', 'Scotland', 'Wales']
      @results_key = @response['result'] 
      @codes_hash = @response['result']['codes']
    end

    it "should respond with a status message of 200" do
      expect(@response['status']).to eq 200
    end

    it "should have a results hash" do
      expect(@results_key).to be_a(Hash)
      
    end

    it "should return a postcode between 5-7 in length"  do
      @results_key['postcode'].gsub!(/\s+/, '')
    
      expect(@results_key['postcode'].length).to be_between(5,7)
      
    end

    it "should return an quality key integer between 1-9" do
      expect(@results_key['quality']).to be_a(Integer)
      expect(@results_key['quality']).to be_between(1,9)

    end

    it "should return an ordnance survey eastings value as integer" do
      expect(@results_key['eastings']).to be_a(Integer)
      
    end

    it "should return an ordnance survey northings value as integer" do
      expect(@results_key['northings']).to be_a(Integer)

    end

    it "should return a country which is one of the four constituent countries of the UK" do

      expect(@results_key['country']).to include(@UK_contries_array[0])
      
    end

    it "should return a string value for NHS authority " do
      expect(@results_key['nhs_ha']).not_to be_empty
      expect(@results_key['nhs_ha']).to be_a(String)

    end

    it "should return a longitude float value" do
      expect(@results_key['longitude']).to be_a(Float)
      
    end

    it "should return a latitude float value" do
      expect(@results_key['latitude']).to be_a(Float)
      
    end

    it "should return a parliamentary constituency string" do
      expect(@results_key['parliamentary_constituency']).to be_a(String)
      expect(@codes_hash['parliamentary_constituency']).to be_a(String)
      
    end

    it "should return a european_electoral_region string" do
      expect(@results_key['european_electoral_region']).to be_a(String)

    end

    it "should return a primary_care_trust string" do
      expect(@results_key['primary_care_trust']).to be_a(String)

    end

    it "should return a region string" do
      expect(@results_key['region']).to be_a(String)
      
    end

    it "should return a parish string" do
      expect(@results_key['parish']).to be_a(String)
      
    end

    it "should return a lsoa string" do
      expect(@results_key['lsoa']).to be_a(String)
      
    end

    it "should return a msoa string" do
      expect(@results_key["msoa"]).to be_a(String)
      
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
      expect(@codes_hash['admin_district']).to be_a(String)
      
    end

    it "should return a incode string of three characters" do
      expect(@results_key['incode'].length).to eq 3
      expect(@results_key['incode']).to be_a(String)
      
    end

    it "should return a msoa string" do
      expect(@results_key['msoa']).to be_a(String)
      
    end

    it "should return a incode string of 3-4 characters" do
      expect(@results_key['incode'].length).to be_between(3,4)
      expect(@results_key['incode'].length).to eq 3
    
    end
  end

  context "multiple postcodes validation" do

    before(:all) do
      @postcodesio = Postcodesio.new
      @response = @postcodesio.get_multiple_postcodes(['NN81RG','YO196TB'])
      @first_result = @response['result'][0]
      @second_result = @response['result'][1]
      @UK_contries_array = [ 'England', 'Northern Ireland', 'Scotland', 'Wales']
   
      
    end

    it "should respond with a status message of 200" do
      expect(@response['status']).to eq 200
      
    end

    it "should return the first query as the first postcode in the response" do
      @first_result['result']['postcode'].gsub!(/\s+/, '')

      expect(@first_result['query']).to eq @first_result['result']['postcode']
      
    end

    it "should return the second query as the first postcode in the response" do
      @second_result['result']['postcode'].gsub!(/\s+/, '')

      expect(@second_result['query']).to eq @second_result['result']['postcode']
      
    end

    it "should have a result hash" do
      expect(@first_result['result']).to be_a(Hash)


      
    end

    it "should return a postcode between 5-7 in length"  do
      @second_result['result']['postcode'].gsub!(/\s+/, '')
      expect(@second_result['result']['postcode'].length).to be_between(5,7)

      @first_result['result']['postcode'].gsub!(/\s+/, '')
      expect(@first_result['result']['postcode'].length).to be_between(5,7)


    end

    it "should return an quality key integer between 1-9" do
      expect(@first_result['result']['quality']).to be_between(1,9)
      expect(@second_result['result']['quality']).to be_between(1,9)

      
    end

    it "should return an ordnance survey eastings value as integer" do
      expect(@first_result['result']['eastings']).to be_a(Integer)
      expect(@second_result['result']['eastings']).to be_a(Integer)
      
      
      
    end

    it "should return an ordnance survey northings value as integer" do
      expect(@first_result['result']['northings']).to be_a(Integer)
      expect(@second_result['result']['northings']).to be_a(Integer)
      
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      expect(@first_result['result']['country']).to eq @UK_contries_array[0]
      expect(@second_result['result']['country']).to eq @UK_contries_array[0]
      
    end

    it "should return a string value for NHS authority " do
      
      expect(@first_result['result']['nhs_ha']).not_to be_empty
      expect(@second_result['result']['nhs_ha']).not_to be_empty

      expect(@first_result['result']['nhs_ha']).to be_a(String)
      expect(@second_result['result']['nhs_ha']).to be_a(String)
      
    end

    it "should return a longitude float value" do

      expect(@first_result['result']['longitude']).to be_a(Float)
      expect(@second_result['result']['longitude']).to be_a(Float)
      
    end

    it "should return a latitude float value" do
      expect(@first_result['result']['latitude']).to be_a(Float)
      expect(@second_result['result']['latitude']).to be_a(Float)
      
      
    end

    it "should return a parliamentary constituency string" do
      
      expect(@first_result['result']['parliamentary_constituency']).to be_a(String)
      expect(@second_result['result']['parliamentary_constituency']).to be_a(String)
      
      expect(@first_result['result']['codes']['parliamentary_constituency']).to be_a(String)
      expect(@second_result['result']['codes']['parliamentary_constituency']).to be_a(String)
      
    end

    it "should return a european_electoral_region string" do
      expect(@first_result['result']['european_electoral_region']).to be_a(String)
      expect(@second_result['result']['european_electoral_region']).to be_a(String)
    end

    it "should return a primary_care_trust string" do
      expect(@first_result['result']['primary_care_trust']).to be_a(String)
      expect(@second_result['result']['primary_care_trust']).to be_a(String)
      
    end

    it "should return a region string" do
      expect(@first_result['result']['region']).to be_a(String)
      expect(@second_result['result']['region']).to be_a(String)
      
    end

    it "should return a parish string" do
      expect(@first_result['result']['parish']).to be_a(String)
      expect(@second_result['result']['parish']).to be_a(String)
      
    end

    it "should return a lsoa string" do
      expect(@first_result['result']['lsoa']).to be_a(String)
      expect(@second_result['result']['lsoa']).to be_a(String)
      
    end

    it "should return a msoa string" do
      expect(@first_result['result']['msoa']).to be_a(String)
      expect(@second_result['result']['msoa']).to be_a(String)
      
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
      expect(@first_result['result']['codes']['admin_district']).to be_a(String)
      expect(@second_result['result']['codes']['admin_district']).to be_a(String)
      
    end

    it "should return a incode string of three characters" do
      expect(@first_result['result']['incode']).to be_a(String)
      expect(@second_result['result']['incode']).to be_a(String)
      
      expect(@first_result['result']['incode'].length).to eq 3
      expect(@second_result['result']['incode'].length).to eq 3

      
    end

    it "should return a msoa string" do
      expect(@first_result['result']['msoa']).to be_a(String)
      expect(@second_result['result']['msoa']).to be_a(String)
      
    end

    it "should return a incode string of 3-4 characters" do
      expect(@first_result['result']['incode']).to be_a(String)
      expect(@second_result['result']['incode']).to be_a(String)
      
      expect(@first_result['result']['incode'].length).to be_between(3,4)
      expect(@second_result['result']['incode'].length).to be_between(3,4)
      
     
    end

    it "should have a results hash" do

      expect(@second_result['result']).to be_a(Hash)
    
    end

    it "should return a postcode between 5-7 in length"  do
      @second_result['result']['postcode'].gsub!(/\s+/, '')
      expect(@second_result['result']['postcode'].length).to be_between(5,7)

      @first_result['result']['postcode'].gsub!(/\s+/, '')
      expect(@first_result['result']['postcode'].length).to be_between(5,7)
      
    end

    it "should return an quality key integer between 1-9" do
      expect(@first_result['result']['quality']).to be_a(Integer)
      expect(@first_result['result']['quality']).to be_a(Integer)
      
      expect(@first_result['result']['quality']).to be_between(1,9)
      expect(@first_result['result']['quality']).to be_between(1,9)
      
    end

    it "should return an ordnance survey eastings value as integer" do
      pending
    end

    it "should return an ordnance survey eastings value as integer" do
      pending
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      pending
    end

    it "should return a string value for NHS authority " do
      pending
    end

    it "should return a longitude float value" do
      pending
    end

    it "should return a latitude float value" do
      pending
    end

    it "should return a parliamentary constituency string" do
      pending
    end

    it "should return a european_electoral_region string" do
      pending
    end

    it "should return a primary_care_trust string" do
      pending
    end

    it "should return a region string" do
      pending
    end

    it "should return a parish string" do
      pending
    end

    it "should return a lsoa string" do
      pending
    end

    it "should return a msoa string" do
      pending
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
      pending
    end

    it "should return a incode string of three characters" do
      pending
    end

    it "should return a msoa string" do
      pending
    end

    it "should return a incode string of 3-4 characters" do
      pending
    end

  end


end
