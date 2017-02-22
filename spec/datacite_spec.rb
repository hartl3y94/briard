require 'spec_helper'

describe Bolognese::Datacite, vcr: true do
  let(:id) { "https://doi.org/10.5061/DRYAD.8515" }

  subject { Bolognese::Datacite.new(id: id) }

  context "get metadata" do
    it "Dataset" do
      expect(subject.id).to eq("https://doi.org/10.5061/dryad.8515")
      expect(subject.type).to eq("Dataset")
      expect(subject.additional_type).to eq("DataPackage")
      expect(subject.resource_type_general).to eq("Dataset")
      expect(subject.author).to eq([{"@type"=>"Person", "givenName"=>"Benjamin", "familyName"=>"Ollomo"},
                                    {"@type"=>"Person", "givenName"=>"Patrick", "familyName"=>"Durand"},
                                    {"@type"=>"Person", "givenName"=>"Franck", "familyName"=>"Prugnolle"},
                                    {"@type"=>"Person", "givenName"=>"Emmanuel J. P.", "familyName"=>"Douzery"},
                                    {"@type"=>"Person", "givenName"=>"Céline", "familyName"=>"Arnathau"},
                                    {"@type"=>"Person", "givenName"=>"Dieudonné", "familyName"=>"Nkoghe"},
                                    {"@type"=>"Person", "givenName"=>"Eric", "familyName"=>"Leroy"},
                                    {"@type"=>"Person", "givenName"=>"François", "familyName"=>"Renaud"}])
      expect(subject.name).to eq("Data from: A new malaria agent in African hominids.")
      expect(subject.alternate_name).to eq("Ollomo B, Durand P, Prugnolle F, Douzery EJP, Arnathau C, Nkoghe D, Leroy E, Renaud F (2009) A new malaria agent in African hominids. PLoS Pathogens 5(5): e1000446.")
      expect(subject.license).to eq("http://creativecommons.org/publicdomain/zero/1.0/")
      expect(subject.date_published).to eq("2011")
      expect(subject.has_part).to eq([{"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.5061/dryad.8515/1"},
                                      {"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.5061/dryad.8515/2"}])
      expect(subject.citation).to eq([{"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.1371/journal.ppat.1000446"}])
      expect(subject.publisher).to eq("@type"=>"Organization", "name"=>"Dryad Digital Repository")
      expect(subject.provider).to eq("@type"=>"Organization", "name"=>"DataCite")
      expect(subject.schema_version).to eq("http://datacite.org/schema/kernel-3")
    end

    it "BlogPosting" do
      id = "https://doi.org/10.5438/4K3M-NYVG"
      subject = Bolognese::Datacite.new(id: id)
      expect(subject.id).to eq("https://doi.org/10.5438/4k3m-nyvg")
      expect(subject.type).to eq("ScholarlyArticle")
      expect(subject.additional_type).to eq("BlogPosting")
      expect(subject.resource_type_general).to eq("Text")
      expect(subject.author).to eq([{"@type"=>"Person", "@id"=>"http://orcid.org/0000-0003-1419-2405", "givenName"=>"Martin", "familyName"=>"Fenner"}])
      expect(subject.name).to eq("Eating your own Dog Food")
      expect(subject.alternate_name).to eq("MS-49-3632-5083")
      expect(subject.description).to start_with("Eating your own dog food")
      expect(subject.date_published).to eq("2016-12-20")
      expect(subject.date_modified).to eq("2016-12-20")
      expect(subject.is_part_of).to eq("@type"=>"CreativeWork", "@id"=>"https://doi.org/10.5438/0000-00ss")
      expect(subject.citation).to eq([{"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.5438/0012"},
                                      {"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.5438/55e5-t5c0"}])
      expect(subject.publisher).to eq("@type"=>"Organization", "name"=>"DataCite")
      expect(subject.provider).to eq("@type"=>"Organization", "name"=>"DataCite")
      expect(subject.schema_version).to eq("http://datacite.org/schema/kernel-4")
    end

    it "Date" do
      id = "https://doi.org/10.4230/lipics.tqc.2013.93"
      subject = Bolognese::Datacite.new(id: id)
      expect(subject.id).to eq("https://doi.org/10.4230/lipics.tqc.2013.93")
      expect(subject.type).to eq("ScholarlyArticle")
      expect(subject.additional_type).to eq("ConferencePaper")
      expect(subject.resource_type_general).to eq("Text")
      expect(subject.author).to eq([{"@type"=>"Person", "givenName"=>"Nathaniel", "familyName"=>"Johnston"}])
      expect(subject.name).to eq("The Minimum Size of Qubit Unextendible Product Bases")
      expect(subject.description).to start_with("We investigate the problem of constructing unextendible product bases in the qubit case")
      expect(subject.date_published).to eq("2013")
      expect(subject.publisher).to eq("@type"=>"Organization", "name"=>"Schloss Dagstuhl - Leibniz-Zentrum fuer Informatik GmbH, Wadern/Saarbruecken, Germany")
      expect(subject.provider).to eq("@type"=>"Organization", "name"=>"DataCite")
      expect(subject.schema_version).to eq("http://datacite.org/schema/kernel-2.1")
    end

    it "Funding schema version 3" do
      id = "https://doi.org/10.5281/ZENODO.1239"
      subject = Bolognese::Datacite.new(id: id)
      expect(subject.id).to eq("https://doi.org/10.5281/zenodo.1239")
      expect(subject.type).to eq("Dataset")
      expect(subject.additional_type).to eq("Dataset")
      expect(subject.resource_type_general).to eq("Dataset")
      expect(subject.author).to eq([{"@type"=>"Person", "givenName"=>"Najko", "familyName"=>"Jahn"},
                                    {"@type"=>"Person", "givenName"=>"Martin", "familyName"=>"Fenner"},
                                    {"@type"=>"Person", "givenName"=>"Harry", "familyName"=>"Dimitropoulos"},
                                    {"@type"=>"Person", "givenName"=>"Jochen", "familyName"=>"Schirrwagen"}])
      expect(subject.name).to eq("Publication FP7 Funding Acknowledgment - PLOS OpenAIRE")
      expect(subject.description).to start_with("The dataset contains a sample of metadata describing papers")
      expect(subject.date_published).to eq("2013-04-03")
      expect(subject.publisher).to eq("@type"=>"Organization", "name"=>"OpenAIRE Orphan Record Repository")
      expect(subject.funder).to eq("@type"=>"Organization", "name"=>"European Commission")
      expect(subject.provider).to eq("@type"=>"Organization", "name"=>"DataCite")
      expect(subject.schema_version).to eq("http://datacite.org/schema/kernel-3")
    end

    it "Funding schema version 4" do
      id = "https://doi.org/10.5438/6423"
      subject = Bolognese::Datacite.new(id: id)
      expect(subject.id).to eq("https://doi.org/10.5438/6423")
      expect(subject.type).to eq("Collection")
      expect(subject.additional_type).to eq("Project")
      expect(subject.resource_type_general).to eq("Collection")
      expect(subject.author.length).to eq(24)
      expect(subject.author.first).to eq("@type"=>"Person", "@id"=>"http://orcid.org/0000-0001-5331-6592", "givenName"=>"Adam", "familyName"=>"Farquhar")
      expect(subject.name).to eq("Technical and Human Infrastructure for Open Research (THOR)")
      expect(subject.description).to start_with("<p>Five years ago, a global infrastructure")
      expect(subject.date_published).to eq("2015")
      expect(subject.publisher).to eq("@type"=>"Organization", "name"=>"DataCite")
      expect(subject.funder).to eq("@type"=>"Organization", "@id"=>"https://doi.org/10.13039/501100000780", "name"=>"European Commission")
      expect(subject.provider).to eq("@type"=>"Organization", "name"=>"DataCite")
      expect(subject.schema_version).to eq("http://datacite.org/schema/kernel-4")
    end

    it "Schema.org JSON" do
      json = JSON.parse(subject.as_schema_org)
      expect(json["@id"]).to eq("https://doi.org/10.5061/dryad.8515")
    end
  end

  context "get metadata as string" do
    it "Dataset" do
      id = "https://doi.org/10.5061/DRYAD.8515"
      string = Bolognese::Datacite.new(id: id).as_datacite

      subject = Bolognese::Datacite.new(string: string)
      expect(subject.id).to eq("https://doi.org/10.5061/dryad.8515")
      expect(subject.type).to eq("Dataset")
      expect(subject.additional_type).to eq("DataPackage")
      expect(subject.resource_type_general).to eq("Dataset")
      expect(subject.author).to eq([{"@type"=>"Person", "givenName"=>"Benjamin", "familyName"=>"Ollomo"},
                                    {"@type"=>"Person", "givenName"=>"Patrick", "familyName"=>"Durand"},
                                    {"@type"=>"Person", "givenName"=>"Franck", "familyName"=>"Prugnolle"},
                                    {"@type"=>"Person", "givenName"=>"Emmanuel J. P.", "familyName"=>"Douzery"},
                                    {"@type"=>"Person", "givenName"=>"Céline", "familyName"=>"Arnathau"},
                                    {"@type"=>"Person", "givenName"=>"Dieudonné", "familyName"=>"Nkoghe"},
                                    {"@type"=>"Person", "givenName"=>"Eric", "familyName"=>"Leroy"},
                                    {"@type"=>"Person", "givenName"=>"François", "familyName"=>"Renaud"}])
      expect(subject.name).to eq("Data from: A new malaria agent in African hominids.")
      expect(subject.alternate_name).to eq("Ollomo B, Durand P, Prugnolle F, Douzery EJP, Arnathau C, Nkoghe D, Leroy E, Renaud F (2009) A new malaria agent in African hominids. PLoS Pathogens 5(5): e1000446.")
      expect(subject.license).to eq("http://creativecommons.org/publicdomain/zero/1.0/")
      expect(subject.date_published).to eq("2011")
      expect(subject.has_part).to eq([{"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.5061/dryad.8515/1"},
                                      {"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.5061/dryad.8515/2"}])
      expect(subject.citation).to eq([{"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.1371/journal.ppat.1000446"}])
      expect(subject.provider).to eq("@type"=>"Organization", "name"=>"DataCite")
    end
  end

  context "get metadata as datacite xml 4.0" do
    it "Dataset" do
      id = "https://doi.org/10.5061/DRYAD.8515"
      subject = Bolognese::Datacite.new(id: id, schema_version: "http://datacite.org/schema/kernel-4")
      expect(subject.id).to eq("https://doi.org/10.5061/dryad.8515")
      expect(subject.type).to eq("Dataset")
      expect(subject.additional_type).to eq("DataPackage")
      expect(subject.resource_type_general).to eq("Dataset")
      expect(subject.author).to eq([{"@type"=>"Person", "givenName"=>"Benjamin", "familyName"=>"Ollomo"},
                                    {"@type"=>"Person", "givenName"=>"Patrick", "familyName"=>"Durand"},
                                    {"@type"=>"Person", "givenName"=>"Franck", "familyName"=>"Prugnolle"},
                                    {"@type"=>"Person", "givenName"=>"Emmanuel J. P.", "familyName"=>"Douzery"},
                                    {"@type"=>"Person", "givenName"=>"Céline", "familyName"=>"Arnathau"},
                                    {"@type"=>"Person", "givenName"=>"Dieudonné", "familyName"=>"Nkoghe"},
                                    {"@type"=>"Person", "givenName"=>"Eric", "familyName"=>"Leroy"},
                                    {"@type"=>"Person", "givenName"=>"François", "familyName"=>"Renaud"}])
      expect(subject.name).to eq("Data from: A new malaria agent in African hominids.")
      expect(subject.alternate_name).to eq("Ollomo B, Durand P, Prugnolle F, Douzery EJP, Arnathau C, Nkoghe D, Leroy E, Renaud F (2009) A new malaria agent in African hominids. PLoS Pathogens 5(5): e1000446.")
      expect(subject.license).to eq("http://creativecommons.org/publicdomain/zero/1.0/")
      expect(subject.date_published).to eq("2011")
      expect(subject.has_part).to eq([{"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.5061/dryad.8515/1"},
                                      {"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.5061/dryad.8515/2"}])
      expect(subject.citation).to eq([{"@type"=>"CreativeWork", "@id"=>"https://doi.org/10.1371/journal.ppat.1000446"}])
      expect(subject.publisher).to eq("@type"=>"Organization", "name"=>"Dryad Digital Repository")
      expect(subject.provider).to eq("@type"=>"Organization", "name"=>"DataCite")
      expect(subject.schema_version).to eq("http://datacite.org/schema/kernel-4")

      datacite = Maremma.from_xml(subject.as_datacite).fetch("resource", {})
      expect(datacite.fetch("xsi:schemaLocation", "").split(" ").first).to eq("http://datacite.org/schema/kernel-4")
    end

    it "Funding" do
      id = "https://doi.org/10.5438/6423"
      subject = Bolognese::Datacite.new(id: id, schema_version: "http://datacite.org/schema/kernel-4")
      expect(subject.id).to eq("https://doi.org/10.5438/6423")

      datacite = Maremma.from_xml(subject.as_datacite).fetch("resource", {})
      expect(datacite.fetch("xsi:schemaLocation", "").split(" ").first).to eq("http://datacite.org/schema/kernel-4")
      expect(datacite.fetch("fundingReferences")).to eq("fundingReference"=>{"funderName"=>"European Commission", "funderIdentifier"=>{"funderIdentifierType"=>"Crossref Funder ID", "__content__"=>"https://doi.org/10.13039/501100000780"}})
    end
  end

  context "get metadata as bibtex" do
    it "Dataset" do
      bibtex = BibTeX.parse(subject.as_bibtex).to_a(quotes: '').first
      expect(bibtex[:bibtex_type].to_s).to eq("misc")
      expect(bibtex[:bibtex_key]).to eq("https://doi.org/10.5061/dryad.8515")
      expect(bibtex[:doi]).to eq("10.5061/DRYAD.8515")
      expect(bibtex[:title]).to eq("Data from: A new malaria agent in African hominids.")
      expect(bibtex[:author]).to eq("Ollomo, Benjamin and Durand, Patrick and Prugnolle, Franck and Douzery, Emmanuel J. P. and Arnathau, Céline and Nkoghe, Dieudonné and Leroy, Eric and Renaud, François")
      expect(bibtex[:publisher]).to eq("Dryad Digital Repository")
      expect(bibtex[:year]).to eq("2011")
    end

    it "BlogPosting" do
      id = "https://doi.org/10.5438/4K3M-NYVG"
      subject = Bolognese::Datacite.new(id: id)
      bibtex = BibTeX.parse(subject.as_bibtex).to_a(quotes: '').first
      expect(bibtex[:bibtex_type].to_s).to eq("article")
      expect(bibtex[:bibtex_key]).to eq("https://doi.org/10.5438/4k3m-nyvg")
      expect(bibtex[:doi]).to eq("10.5438/4K3M-NYVG")
      expect(bibtex[:title]).to eq("Eating your own Dog Food")
      expect(bibtex[:author]).to eq("Fenner, Martin")
      expect(bibtex[:publisher]).to eq("DataCite")
      expect(bibtex[:year]).to eq("2016")
    end
  end
end