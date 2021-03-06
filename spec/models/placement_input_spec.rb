require 'rails_helper'

RSpec.describe PlacementInput, type: :model do


  it 'should create a placement input' do
    # Create the campaign input
    network = Network.create!(name: 'Comedy Central', abbrev: 'CCL')
    campaign_input = CampaignInput.create!(
      network: network,
      program: Program.create!(name: 'Clusterfest', abbrev: 'CLTF', network_id: network.id),
      campaign_type: CampaignType.create!(name: 'Binge', abbrev: 'BG'),
      season: Season.create!(name: 'S00', abbrev: 's00'),
      custom: 'xx',
      start_month: '01',
      start_day: '21',
      start_year: 2017,
      end_day: '21',
      end_month: '02',
      end_year: 2017,
      campaign_input_tag: 'CCL_ CLTF_ S00_ BG_ xx_20170121-20170221'
    )

    package_input = PackageInput.create!(
      campaign_input: campaign_input,
      agency: Agency.create!(name: 'Sterling Cooper', abbrev: 'sc'),
      publisher: Publisher.create!(name: 'ABC', abbrev: 'ABCX'),
      buy_method: BuyMethod.create!(name: 'CPA', abbrev: 'CPA'),
      inventory_type: InventoryType.create!(name: 'Partner Social Distribution', abbrev: 'PSD'),
      custom: 'xx',
      package_input_tag: 'CCL_CLTF_S00_SC_ABCX_CPA_PSD_xx'
    )

    placement_input = PlacementInput.create!(
      package_input: package_input,
      tactic: Tactic.create!(name: 'Audio', abbrev: 'AUD'),
      device: Device.create!(name: 'Over the Top', abbrev: 'OTT'),
      ad_type: AdType.create!(name: 'Animated Gif', abbrev: 'GIF'),
      audience_type: 'XO',
      width: 600,
      height: 120,
      targeting_type_1: TargetingType.create!(name: 'Behavioral', abbrev: 'BT'),
      targeting_type_2: TargetingType.create!(name: 'Contextual', abbrev: 'CT'),
      targeting_type_3: TargetingType.create!(name: 'Day Parting', abbrev: 'DP'),
      targeting_type_4: TargetingType.create!(name: 'Publisher Data', abbrev: 'PD'),
      episode_start: Episode.create!(name: 'E01', abbrev: 'E01'),
      episode_end: Episode.create!(name: 'E05', abbrev: 'E05'),
      placement_input_tag: 'CCL_CLTF_E01_SC_AUD_OTT_ABCX_CPA_GIF_PSD_BT_XO_'
    )
    expect(placement_input.tactic.name).to include('Audio')
    expect(placement_input.ad_type.name).to include('Animated Gif')
    expect(package_input.placement_inputs.length).to eq(1)
  end

  it 'should raise an error if tentpole details are not included' do
    network = Network.create!(name: 'Comedy Central', abbrev: 'CCL')
    campaign_input = CampaignInput.create!(
      network: network,
      program: Program.create!(name: 'Clusterfest', abbrev: 'CLTF', network_id: network.id),
      campaign_type: CampaignType.create!(name: 'Binge', abbrev: 'BG'),
      season: Season.create!(name: 'Tentpole', abbrev: 'TPL'),
      custom: 'xx',
      start_month: '01',
      start_day: '21',
      start_year: 2017,
      end_day: '21',
      end_month: '02',
      end_year: 2017,
      campaign_input_tag: 'CCL_ CLTF_ S00_ BG_ xx_20170121-20170221'
    )

    package_input = PackageInput.create!(
      campaign_input: campaign_input,
      agency: Agency.create!(name: 'Sterling Cooper', abbrev: 'sc'),
      publisher: Publisher.create!(name: 'ABC', abbrev: 'ABCX'),
      buy_method: BuyMethod.create!(name: 'CPA', abbrev: 'CPA'),
      inventory_type: InventoryType.create!(name: 'Partner Social Distribution', abbrev: 'PSD'),
      custom: 'xx',
      package_input_tag: 'CCL_CLTF_S00_SC_ABCX_CPA_PSD_xx'
    )

    placement_input = PlacementInput.new(
      package_input: package_input,
      tactic: Tactic.create!(name: 'Audio', abbrev: 'AUD'),
      device: Device.create!(name: 'Over the Top', abbrev: 'OTT'),
      ad_type: AdType.create!(name: 'Animated Gif', abbrev: 'GIF'),
      audience_type: 'XO',
      width: 600,
      height: 120,
      targeting_type_1: TargetingType.create!(name: 'Behavioral', abbrev: 'BT'),
      targeting_type_2: TargetingType.create!(name: 'Contextual', abbrev: 'CT'),
      targeting_type_3: TargetingType.create!(name: 'Day Parting', abbrev: 'DP'),
      targeting_type_4: TargetingType.create!(name: 'Publisher Data', abbrev: 'PD'),
      episode_start: Episode.create!(name: 'E01', abbrev: 'E01'),
      episode_end: Episode.create!(name: 'E05', abbrev: 'E05'),
      placement_input_tag: 'CCL_CLTF_E01_SC_AUD_OTT_ABCX_CPA_GIF_PSD_BT_XO_'
    )
    expect(placement_input).to_not be_valid
    expect(placement_input.package_input.campaign_input.start_month).to eq '01'
    expect(placement_input.errors.messages[:tentpole_details]).to include("can't be blank")
  end

  it 'should raise an error if episode dates are not included' do
    network = Network.create!(name: 'Comedy Central', abbrev: 'CCL')
    campaign_input = CampaignInput.create!(
      network: network,
      program: Program.create!(name: 'Clusterfest', abbrev: 'CLTF', network_id: network.id),
      campaign_type: CampaignType.create!(name: 'Binge', abbrev: 'BG'),
      season: Season.create!(name: 'S01', abbrev: 'S01'),
      custom: 'xx',
      start_month: '01',
      start_day: '21',
      start_year: 2017,
      end_day: '21',
      end_month: '02',
      end_year: 2017,
      campaign_input_tag: 'CCL_ CLTF_ S00_ BG_ xx_20170121-20170221'
    )

    package_input = PackageInput.create!(
      campaign_input: campaign_input,
      agency: Agency.create!(name: 'Sterling Cooper', abbrev: 'sc'),
      publisher: Publisher.create!(name: 'ABC', abbrev: 'ABCX'),
      buy_method: BuyMethod.create!(name: 'CPA', abbrev: 'CPA'),
      inventory_type: InventoryType.create!(name: 'Partner Social Distribution', abbrev: 'PSD'),
      custom: 'xx',
      package_input_tag: 'CCL_CLTF_S00_SC_ABCX_CPA_PSD_xx'
    )

    placement_input = PlacementInput.new(
      package_input: package_input,
      tactic: Tactic.create!(name: 'Audio', abbrev: 'AUD'),
      device: Device.create!(name: 'Over the Top', abbrev: 'OTT'),
      ad_type: AdType.create!(name: 'Animated Gif', abbrev: 'GIF'),
      audience_type: 'XO',
      width: 600,
      height: 120,
      targeting_type_1: TargetingType.create!(name: 'Behavioral', abbrev: 'BT'),
      targeting_type_2: TargetingType.create!(name: 'Contextual', abbrev: 'CT'),
      targeting_type_3: TargetingType.create!(name: 'Day Parting', abbrev: 'DP'),
      targeting_type_4: TargetingType.create!(name: 'Publisher Data', abbrev: 'PD'),
      placement_input_tag: 'CCL_CLTF_E01_SC_AUD_OTT_ABCX_CPA_GIF_PSD_BT_XO_'
    )
    expect(placement_input).to_not be_valid
    expect(placement_input.errors.messages[:episode_start_id]).to include("can't be blank")
    expect(placement_input.errors.messages[:episode_end_id]).to include("can't be blank")
    expect(placement_input.tactic.name).to eq "Audio"
    expect(placement_input.device.name).to eq "Over the Top"
    expect(placement_input.ad_type.name).to eq 'Animated Gif'
    expect(placement_input.targeting_type_1.name).to eq  'Behavioral'
    expect(placement_input.targeting_type_2.name).to eq  'Contextual'
    expect(placement_input.targeting_type_3.name).to eq  'Day Parting'
    expect(placement_input.targeting_type_4.name).to eq  'Publisher Data'
    expect(placement_input.episode_start).to eq nil
    expect(placement_input.episode_end).to eq nil
  end
end
