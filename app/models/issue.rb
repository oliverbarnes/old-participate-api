class Issue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :area_id,                       type: Integer               
  field :policy_id,                     type: Integer                            
  field :admin_notice                        
  field :state                               
  field :phase_finished,                type: Time        
  field :accepted,                      type: Time              
  field :half_frozen,                   type: Time           
  field :fully_frozen,                  type: Time          
  field :closed,                        type: Time                
  field :cleaned,                       type: Time               
  field :admission_time_in_seconds,     type: Integer, default: 0
  field :discussion_time_in_seconds,    type: Integer, default: 0 
  field :verification_time_in_seconds,  type: Integer, default: 0 
  field :voting_time_in_seconds,        type: Integer, default: 0 
  field :snapshot,                      type: Time                   
  field :latest_snapshot_event #? 
  field :population,                    type: Integer             
  field :voter_count,                   type: Integer           
  field :status_quo_schulze_rank,       type: Integer
  field :title
  field :description

  alias_method :created, :created_at

  # First stab at returning LF's interval fields
  [ :admission_time, :discussion_time, :verification_time, :voting_time ].each do |interval_method|
    define_method( interval_method ) do
      eval("#{interval_method}_in_seconds").seconds
    end
  end


end