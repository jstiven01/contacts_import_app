describe ImportFilePolicy do
    subject { described_class }
  
    permissions :new? do
      it "denies access to new" do
        expect(subject).not_to permit(nil, ImportFile.new())
      end
      it "grants access to new if user is registered" do
        user = FactoryBot.create(:user)
        expect(subject).to permit(user, ImportFile.new())
      end
    end

    permissions :index? do
        it "grants access to index" do
          expect(subject).to permit(nil, ImportFile.new())
        end
        it "grants access to index if user is registered" do
          user = FactoryBot.create(:user)
          expect(subject).to permit(user, ImportFile.new())
        end
    end
end