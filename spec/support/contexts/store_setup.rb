RSpec.shared_context "user_setup" do
  shared_context "store_setup" do
    let!(:store_manager) { create(:store_manager) }
    let!(:store) { create(:store, store_manager_id: store_manager.id ) }
  end
end