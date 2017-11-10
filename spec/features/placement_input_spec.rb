require 'rails_helper'

RSpec.feature 'Placement Input', type: :feature, js: true do
  before do
    visit('/')
    @user = FactoryGirl.create(:user)
    network = Network.create(name: 'Comedy Central', abbrev: 'CCL')
    Program.create(name: 'Clusterfest', abbrev: 'CLTF', network_id: network.id)
    Season.create!(name: 'S00', abbrev: 'S00')
    CampaignType.create!(name: 'Binge', abbrev: 'BG')
    Agency.create(name: 'Sterling Cooper', abbrev: 'SC')
    BuyMethod.create!(name: 'CPA', abbrev: 'CPA')
    Publisher.create!(name: 'ABC', abbrev: 'ABCX')
    InventoryType.create!(name: 'Partner Social Distribution', abbrev: 'PSD')
    Tactic.create!(name: 'Audio', abbrev: 'AUD')
    Device.create!(name: 'Over the Top', abbrev: 'OTT')
    Device.create!(name: 'Desktop', abbrev: 'DXX')
    AdType.create!(name: 'Animated Gif', abbrev: 'GIF')
    TargetingType.create!(name: 'Behavioral', abbrev: 'BT')
    TargetingType.create!(name: 'None', abbrev: 'XX')
    Episode.create!(name: 'E01', abbrev: 'E01')
    Episode.create!(name: 'E02', abbrev: 'E02')
  end

  it 'creates a placement input' do
    fill_in('email-login', with: @user.email)
    fill_in('password-login', with: @user.password)
    click_on('Log In')
    click_on('New')
    expect(page).to have_select('Network', options: ['Select Network', 'Comedy Central'])
    select('Comedy Central', from: 'Network')
    expect(page).to have_text('Comedy Central')
    expect(page).to have_select('Program', options: ['Select Program', 'Clusterfest'])
    select('Clusterfest', from: 'Program')
    expect(page).to have_text('Clusterfest')
    expect(page).to have_select('Season', options: ['Select Season', 'S00'])
    select('S00', from: 'Season')
    expect(page).to have_text('S00')
    expect(page).to have_select('Campaign Type', options: ['Select Campaign Type', 'Binge'])
    select('Binge', from: 'Campaign Type')
    expect(page).to have_text('Binge')
    expect(page).to have_field('customCampaign')
    fill_in('customCampaign', with: 'XX')
    expect(page).to have_select('Start Month')
    select('01', from: 'Start Month')
    select('01', from: 'Start Day')
    select('02', from: 'End Month')
    select('02', from: 'End Day')
    expect(page).to have_text('Create Campaign String')
    click_on('Create Campaign String')
    expect(page).to have_text('CCL_CLTF_S00_BG_XX_20170101-20170202')
    expect(page).to have_text('Package Input')
    expect(page).to have_select('Agency', options: ['Select Agency', 'Sterling Cooper'])
    select('Sterling Cooper', from: 'Agency')
    expect(page).to have_select('Publisher', options: ['Select Publisher', 'ABC'])
    select('ABC', from: 'Publisher')
    expect(page).to have_select('Buy Method', options: ['Select Buy Method', 'CPA'])
    select('CPA', from: 'Buy Method')
    expect(page).to have_field('customPackage')
    fill_in('customPackage', with: 'XX')
    expect(page).to have_select('Inventory Type', options: ['Select Inventory Type', 'Partner Social Distribution'])
    select('Partner Social Distribution', from: 'Inventory Type')
    expect(page).to have_text('Create Package String')
    click_on('Create Package String')
    expect(page).to have_text('CCL_CLTF_S00_SC_ABCX_CPA_PSD_XX')
    expect(page).to have_text('Placement Input')
    expect(page).to have_select('Episode Start', options: ['Select Episode Start', 'E01', 'E02'])
    select('E01', from: 'Episode Start')
    expect(page).to have_select('Episode End', options: ['Select Episode End', 'E01', 'E02'])
    select('E02', from: 'Episode End')
    expect(page).to have_select('Tactic', options: ['Select Tactic', 'Audio'])
    select('Audio', from: 'Tactic')
    expect(page).to have_select('Device', options: ['Select Device', 'Over the Top', 'Desktop'])
    select('Over the Top', from: 'Device')
    expect(page).to have_select('Ad Type', options: ['Select Ad Type', 'Animated Gif'])
    select('Animated Gif', from: 'Ad Type')
    expect(page).to have_field('customAudience')
    fill_in('customAudience', with: 'LA')
    expect(page).to have_field('customWidth')
    fill_in('customWidth', with: '100')
    expect(page).to have_field('customHeight')
    fill_in('customHeight', with: '300')
    expect(page).to have_text('Create Placement String')
    expect(page).to have_select('Targeting Type 1', options: ['Select Targeting Type 1', 'Behavioral', 'None'])
    select('Behavioral', from: 'Targeting Type 1')
    click_on('Create Placement String')
    expect(page).to have_text('CCL_CLTF_S00_E01-E02_SC_AUD_OTT_ABCX_CPA_GIF_BT-XX-XX-XX_LA_100x300_0101-0202')
  end

  it 'clears a placement input' do
    fill_in('email-login', with: @user.email)
    fill_in('password-login', with: @user.password)
    click_on('Log In')
    click_on('New')
    expect(page).to have_select('Network', options: ['Select Network', 'Comedy Central'])
    select('Comedy Central', from: 'Network')
    expect(page).to have_text('Comedy Central')
    expect(page).to have_select('Program', options: ['Select Program', 'Clusterfest'])
    select('Clusterfest', from: 'Program')
    expect(page).to have_text('Clusterfest')
    expect(page).to have_select('Season', options: ['Select Season', 'S00'])
    select('S00', from: 'Season')
    expect(page).to have_text('S00')
    expect(page).to have_select('Campaign Type', options: ['Select Campaign Type', 'Binge'])
    select('Binge', from: 'Campaign Type')
    expect(page).to have_text('Binge')
    expect(page).to have_field('customCampaign')
    fill_in('customCampaign', with: 'XX')
    expect(page).to have_select('Start Month')
    select('01', from: 'Start Month')
    select('01', from: 'Start Day')
    select('02', from: 'End Month')
    select('02', from: 'End Day')
    expect(page).to have_text('Create Campaign String')
    click_on('Create Campaign String')
    expect(page).to have_text('CCL_CLTF_S00_BG_XX_20170101-20170202')
    expect(page).to have_text('Package Input')
    expect(page).to have_select('Agency', options: ['Select Agency', 'Sterling Cooper'])
    select('Sterling Cooper', from: 'Agency')
    expect(page).to have_select('Publisher', options: ['Select Publisher', 'ABC'])
    select('ABC', from: 'Publisher')
    expect(page).to have_select('Buy Method', options: ['Select Buy Method', 'CPA'])
    select('CPA', from: 'Buy Method')
    expect(page).to have_field('customPackage')
    fill_in('customPackage', with: 'XX')
    expect(page).to have_select('Inventory Type', options: ['Select Inventory Type', 'Partner Social Distribution'])
    select('Partner Social Distribution', from: 'Inventory Type')
    expect(page).to have_text('Create Package String')
    click_on('Create Package String')
    expect(page).to have_text('CCL_CLTF_S00_SC_ABCX_CPA_PSD_XX')
    expect(page).to have_text('Placement Input')
    expect(page).to have_select('Episode Start', options: ['Select Episode Start', 'E01', 'E02'])
    select('E01', from: 'Episode Start')
    expect(page).to have_select('Episode End', options: ['Select Episode End', 'E01', 'E02'])
    select('E02', from: 'Episode End')
    expect(page).to have_select('Tactic', options: ['Select Tactic', 'Audio'])
    select('Audio', from: 'Tactic')
    expect(page).to have_select('Device', options: ['Select Device', 'Over the Top', 'Desktop'])
    select('Over the Top', from: 'Device')
    expect(page).to have_select('Ad Type', options: ['Select Ad Type', 'Animated Gif'])
    select('Animated Gif', from: 'Ad Type')
    expect(page).to have_field('customAudience')
    fill_in('customAudience', with: 'LA')
    expect(page).to have_field('customWidth')
    fill_in('customWidth', with: '100')
    expect(page).to have_field('customHeight')
    fill_in('customHeight', with: '300')
    expect(page).to have_text('Create Placement String')
    expect(page).to have_select('Targeting Type 1', options: ['Select Targeting Type 1', 'Behavioral', 'None'])
    select('Behavioral', from: 'Targeting Type 1')
    expect(page).to have_text('Clear')
    click_on('Clear')
    expect(page).to_not have_text('CCL_CLTF_S00_E01-E02_SC_AUD_OTT_ABCX_CPA_GIF_BT-XX-XX-XX_LA_100x300_0101-0202')
  end

  it 'duplicate a placement input' do
    fill_in('email-login', with: @user.email)
    fill_in('password-login', with: @user.password)
    click_on('Log In')
    click_on('New')
    expect(page).to have_select('Network', options: ['Select Network', 'Comedy Central'])
    select('Comedy Central', from: 'Network')
    expect(page).to have_text('Comedy Central')
    expect(page).to have_select('Program', options: ['Select Program', 'Clusterfest'])
    select('Clusterfest', from: 'Program')
    expect(page).to have_text('Clusterfest')
    expect(page).to have_select('Season', options: ['Select Season', 'S00'])
    select('S00', from: 'Season')
    expect(page).to have_text('S00')
    expect(page).to have_select('Campaign Type', options: ['Select Campaign Type', 'Binge'])
    select('Binge', from: 'Campaign Type')
    expect(page).to have_text('Binge')
    expect(page).to have_field('customCampaign')
    fill_in('customCampaign', with: 'XX')
    expect(page).to have_select('Start Month')
    select('01', from: 'Start Month')
    select('01', from: 'Start Day')
    select('02', from: 'End Month')
    select('02', from: 'End Day')
    expect(page).to have_text('Create Campaign String')
    click_on('Create Campaign String')
    expect(page).to have_text('CCL_CLTF_S00_BG_XX_20170101-20170202')
    expect(page).to have_text('Package Input')
    expect(page).to have_select('Agency', options: ['Select Agency', 'Sterling Cooper'])
    select('Sterling Cooper', from: 'Agency')
    expect(page).to have_select('Publisher', options: ['Select Publisher', 'ABC'])
    select('ABC', from: 'Publisher')
    expect(page).to have_select('Buy Method', options: ['Select Buy Method', 'CPA'])
    select('CPA', from: 'Buy Method')
    expect(page).to have_field('customPackage')
    fill_in('customPackage', with: 'XX')
    expect(page).to have_select('Inventory Type', options: ['Select Inventory Type', 'Partner Social Distribution'])
    select('Partner Social Distribution', from: 'Inventory Type')
    expect(page).to have_text('Create Package String')
    click_on('Create Package String')
    expect(page).to have_text('CCL_CLTF_S00_SC_ABCX_CPA_PSD_XX')
    expect(page).to have_text('Placement Input')
    expect(page).to have_select('Episode Start', options: ['Select Episode Start', 'E01', 'E02'])
    select('E01', from: 'Episode Start')
    expect(page).to have_select('Episode End', options: ['Select Episode End', 'E01', 'E02'])
    select('E02', from: 'Episode End')
    expect(page).to have_select('Tactic', options: ['Select Tactic', 'Audio'])
    select('Audio', from: 'Tactic')
    expect(page).to have_select('Device', options: ['Select Device', 'Over the Top', 'Desktop'])
    select('Over the Top', from: 'Device')
    expect(page).to have_select('Ad Type', options: ['Select Ad Type', 'Animated Gif'])
    select('Animated Gif', from: 'Ad Type')
    expect(page).to have_field('customAudience')
    fill_in('customAudience', with: 'LA')
    expect(page).to have_field('customWidth')
    fill_in('customWidth', with: '100')
    expect(page).to have_field('customHeight')
    fill_in('customHeight', with: '300')
    expect(page).to have_text('Create Placement String')
    expect(page).to have_select('Targeting Type 1', options: ['Select Targeting Type 1', 'Behavioral', 'None'])
    select('Behavioral', from: 'Targeting Type 1')
    click_on('Create Placement String')
    expect(page).to have_text('CCL_CLTF_S00_E01-E02_SC_AUD_OTT_ABCX_CPA_GIF_BT-XX-XX-XX_LA_100x300_0101-0202')
    click_on('duplicatePlacement')
    select('Desktop', from: 'Device')
    click_on('Create Placement String')
    expect(page).to have_text('CCL_CLTF_S00_E01-E02_SC_AUD_DXX_ABCX_CPA_GIF_BT-XX-XX-XX_LA_100x300_0101-0202')
  end
end
