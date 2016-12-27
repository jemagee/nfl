require 'rails_helper'

RSpec.describe "Testing the seed data" do

	Rails.application.load_seed

	scenario "Testing that the right amount of divisions are added" do
		expect(Division.count).to eq 8
	end

	scenario "Testing that the each conference has four divisions" do
		expect(Division.afc.count).to eq 4
		expect(Division.nfc.count).to eq 4
	end

	scenario "Testing that the teams load properly" do
		expect(Team.count).to eq 32
	end


	scenario "The NFC East has four teams" do
		expect(Team.where(division: Division.find_by(conference: 'nfc', name:'east')).count).to eq 4
	end

	scenario "The NFC West has four teams" do
		expect(Team.where(division: Division.find_by(conference: 'nfc', name:'west')).count).to eq 4
	end

		scenario "The NFC South has four teams" do
		expect(Team.where(division: Division.find_by(conference: 'nfc', name:'south')).count).to eq 4
	end

		scenario "The NFC North has four teams" do
		expect(Team.where(division: Division.find_by(conference: 'nfc', name:'north')).count).to eq 4
	end

		scenario "The AFC East has four teams" do
		expect(Team.where(division: Division.find_by(conference: 'afc', name:'east')).count).to eq 4
	end

		scenario "The AFC South has four teams" do
		expect(Team.where(division: Division.find_by(conference: 'afc', name:'south')).count).to eq 4
	end

		scenario "The AFC West has four teams" do
		expect(Team.where(division: Division.find_by(conference: 'afc', name:'west')).count).to eq 4
	end

	scenario "The AFC North has four teams" do
		expect(Team.where(division: Division.find_by(conference: 'afc', name:'north')).count).to eq 4
	end
end