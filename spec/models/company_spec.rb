require 'spec_helper'

describe Company do
  context '.create_with_payment(user, title = "Owner" )' do
    it 'should set the maintainer_id'
    it 'should call set_payment_info for stripe info'
    it 'should call make_owner'
  end

  context '.make_owner(user, title = "Owner" )' do
    it 'should set the maintainer_id'
    it 'should set the privilege_ids to give all rights'
  end
end
