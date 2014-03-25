require 'roar/representer/json'

module IssueRepresenter
  include Roar::Representer::JSON

  property :name
  property :area_id               
  property :policy_id             
  property :admin_notice          
  property :state                 
  property :phase_finished        
  property :created               
  property :accepted              
  property :half_frozen           
  property :fully_frozen          
  property :closed                
  property :cleaned               
  property :admission_time        
  property :discussion_time       
  property :verification_time     
  property :voting_time           
  property :snapshot              
  property :latest_snapshot_event 
  property :population            
  property :voter_count           
  property :status_quo_schulze_rank
  property :title
  property :description
end