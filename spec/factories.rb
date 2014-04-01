FactoryGirl.define do
  factory :issue do
    title "Public school in disrepair"
    description "My local school has missing lights, bathrooms that don't work"
    # name "Kofi"
    # area_id 1                     
    # policy_id 1                   
    # admin_notice ''
    # state 'frozen'
    # phase_finished Time.now              
    # accepted Time.now                    
    # half_frozen Time.now                 
    # fully_frozen Time.now                
    # closed Time.now                      
    # cleaned Time.now                     
    # admission_time_in_seconds 0   
    # discussion_time_in_seconds  0  
    # verification_time_in_seconds  0
    # voting_time_in_seconds 0         
    # snapshot Time.now                   
    # latest_snapshot_event ''
    # population 0     
    # voter_count 0                
    # status_quo_schulze_rank 0
  end

  factory :vote do
  end

  factory :member do
    name "Alastair Reynolds"
  end

  factory :delegation do
    issue
    truster { FactoryGirl.create :member }
    trustee { FactoryGirl.create :member, name: "Greg Egan" }
  end
end