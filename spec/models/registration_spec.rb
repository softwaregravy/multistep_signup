# == Schema Information
#
# Table name: registrations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  age        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  state      :string(255)
#

require 'spec_helper'

describe Registration do
  pending "add some examples to (or delete) #{__FILE__}"
end
