describe 'bin/bashly', :slow do
  subject { CLI.runner }

  it 'shows list of commands' do
    expect { subject.run }.to output_approval('cli/commands')
  end

  context 'when an error occurs' do
    it 'displays it nicely' do
      expect(`bin/bashly generate 2>&1`).to match_approval('cli/error')
    end
  end
end
