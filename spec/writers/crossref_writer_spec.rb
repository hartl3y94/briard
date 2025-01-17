# frozen_string_literal: true

require 'spec_helper'

describe Briard::Metadata, vcr: true do
  context 'write metadata as crossref' do
    it 'journal article' do
      input = "#{fixture_path}crossref.xml"
      subject = described_class.new(input: input)
      expect(subject.valid?).to be true
      expect(subject.doi).to eq('10.7554/elife.01567')
      expect(subject.url).to eq('https://elifesciences.org/articles/01567')
      crossref = Maremma.from_xml(subject.crossref).dig('doi_batch', 'body', 'journal')
      expect(crossref.dig('journal_metadata', 'full_title')).to eq('eLife')
      expect(crossref.dig('journal_article', 'doi_data', 'doi')).to eq('10.7554/elife.01567')
    end

    it 'posted_content' do
      subject = described_class.new(input: '10.1101/2020.12.01.406702')
      expect(subject.valid?).to be true
      expect(subject.doi).to eq('10.1101/2020.12.01.406702')
      expect(subject.url).to eq('http://biorxiv.org/lookup/doi/10.1101/2020.12.01.406702')
      crossref = Maremma.from_xml(subject.crossref).dig('doi_batch', 'body', 'posted_content')
      expect(crossref.dig('doi_data', 'doi')).to eq('10.1101/2020.12.01.406702')
    end

    it 'journal article from datacite' do
      input = '10.2312/geowissenschaften.1989.7.181'
      subject = described_class.new(input: input, from: 'datacite')

      expect(subject.valid?).to be true
      expect(subject.doi).to eq('10.2312/geowissenschaften.1989.7.181')
      expect(subject.url).to eq('https://www.tib.eu/suchen/id/awi:7058a56c5e43afd705af945d01536b9aaeeee491')
      expect(subject.types['schemaOrg']).to eq('ScholarlyArticle')
      expect(subject.types['resourceTypeGeneral']).to eq('JournalArticle')
      expect(subject.types['ris']).to eq('JOUR')
      expect(subject.types['citeproc']).to eq('article-journal')
      expect(subject.titles).to eq([{ 'title' => 'An Overview of the Geology of Canadian Gold Occurrences' }])
      expect(subject.publisher).to eq('VCH Verlagsgesellschaft mbH')
      expect(subject.rights_list).to eq([{ 'rights' => 'VCH Verlagsgesellschaft mbH' }])
    end

    it 'schema.org from front matter' do
      input = 'https://blog.front-matter.io/posts/editorial-by-more-than-200-call-for-emergency-action-to-limit-global-temperature-increases-restore-biodiversity-and-protect-health'
      subject = described_class.new(input: input, from: 'schema_org')

      expect(subject.valid?).to be true
      expect(subject.doi).to eq('10.53731/r9nqx6h-97aq74v-ag7bw')
      expect(subject.url).to eq('https://blog.front-matter.io/posts/editorial-by-more-than-200-call-for-emergency-action-to-limit-global-temperature-increases-restore-biodiversity-and-protect-health')
      expect(subject.types['schemaOrg']).to eq('Article')
      expect(subject.types['resourceTypeGeneral']).to eq('Preprint')
      expect(subject.types['ris']).to eq('GEN')
      expect(subject.types['citeproc']).to eq('article-newspaper')
      expect(subject.titles).to eq([{ 'title' => 'Editorial by more than 200 health journals: Call for emergency action to limit global temperature increases, restore biodiversity, and protect health' }])
      expect(subject.creators).to eq([{ 'affiliation' => [],
                                        'familyName' => 'Fenner',
                                        'givenName' => 'Martin',
                                        'name' => 'Fenner, Martin',
                                        'nameIdentifiers' =>
        [{ 'nameIdentifier' => 'https://orcid.org/0000-0003-1419-2405',
           'nameIdentifierScheme' => 'ORCID',
           'schemeUri' => 'https://orcid.org' }],
                                        'nameType' => 'Personal' }])
      expect(subject.subjects).to eq([{ 'subject' => 'news' }])
      expect(subject.language).to eq('en')
      expect(subject.rights_list).to eq([{
                                          'rights' => 'Creative Commons Attribution 4.0 International', 'rightsUri' => 'https://creativecommons.org/licenses/by/4.0/legalcode', 'rightsIdentifier' => 'cc-by-4.0', 'rightsIdentifierScheme' => 'SPDX', 'schemeUri' => 'https://spdx.org/licenses/'
                                        }])
      crossref = Maremma.from_xml(subject.crossref).dig('doi_batch', 'body', 'posted_content')
      expect(crossref.dig('titles',
                          'title')).to eq('Editorial by more than 200 health journals: Call for emergency action to limit global temperature increases, restore biodiversity, and protect health')
    end

    it 'another schema.org from front-matter' do
      input = 'https://blog.front-matter.io/posts/dryad-interview-jen-gibson'
      subject = described_class.new(input: input, from: 'schema_org')
      expect(subject.valid?).to be true
      expect(subject.doi).to eq('10.53731/rceh7pn-tzg61kj-7zv63')
      expect(subject.url).to eq('https://blog.front-matter.io/posts/dryad-interview-jen-gibson')
      expect(subject.types['schemaOrg']).to eq('Article')
      expect(subject.types['resourceTypeGeneral']).to eq('Preprint')
      expect(subject.types['ris']).to eq('GEN')
      expect(subject.types['citeproc']).to eq('article-newspaper')
      expect(subject.titles).to eq([{ 'title' => 'Dryad: Interview with Jen Gibson' }])
      expect(subject.creators).to eq([{ 'affiliation' => [],
                                        'familyName' => 'Fenner',
                                        'givenName' => 'Martin',
                                        'name' => 'Fenner, Martin',
                                        'nameIdentifiers' =>
          [{ 'nameIdentifier' => 'https://orcid.org/0000-0003-1419-2405',
             'nameIdentifierScheme' => 'ORCID',
             'schemeUri' => 'https://orcid.org' }],
                                        'nameType' => 'Personal' }])
      expect(subject.subjects).to eq([{ 'subject' => 'interview' }])
      expect(subject.container).to eq('identifier' => '2749-9952', 'identifierType' => 'ISSN',
                                      'title' => 'Front Matter', 'type' => 'Blog')
      expect(subject.language).to eq('en')
      expect(subject.rights_list).to eq([{
                                          'rights' => 'Creative Commons Attribution 4.0 International', 'rightsUri' => 'https://creativecommons.org/licenses/by/4.0/legalcode', 'rightsIdentifier' => 'cc-by-4.0', 'rightsIdentifierScheme' => 'SPDX', 'schemeUri' => 'https://spdx.org/licenses/'
                                        }])
      crossref = Maremma.from_xml(subject.crossref).dig('doi_batch', 'body', 'posted_content')
      expect(crossref.dig('titles', 'title')).to eq('Dryad: Interview with Jen Gibson')
    end

    it 'embedded schema.org from front matter' do
      input = "#{fixture_path}schema_org_front-matter.json"
      subject = described_class.new(input: input, from: 'schema_org')
      expect(subject.valid?).to be true
      expect(subject.doi).to eq('10.53731/r9nqx6h-97aq74v-ag7bw')
      expect(subject.url).to eq('https://blog.front-matter.io/posts/editorial-by-more-than-200-call-for-emergency-action-to-limit-global-temperature-increases-restore-biodiversity-and-protect-health')
      expect(subject.types['schemaOrg']).to eq('BlogPosting')
      expect(subject.types['resourceTypeGeneral']).to eq('Preprint')
      expect(subject.types['ris']).to eq('GEN')
      expect(subject.types['citeproc']).to eq('post-weblog')
      expect(subject.container).to eq('identifier' => '2749-9952', 'identifierType' => 'ISSN',
                                      'title' => 'Front Matter', 'type' => 'Blog')
      expect(subject.titles).to eq([{ 'title' => 'Editorial by more than 200 health journals: Call for emergency action to limit global temperature increases, restore biodiversity, and protect health' }])
      crossref = Maremma.from_xml(subject.crossref).dig('doi_batch', 'body', 'posted_content')
      expect(crossref.dig('titles',
                          'title')).to eq('Editorial by more than 200 health journals: Call for emergency action to limit global temperature increases, restore biodiversity, and protect health')
    end
  end
end
