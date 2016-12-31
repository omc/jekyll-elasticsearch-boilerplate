// search comopnent!

import React, {Component} from 'react';
import Searchkit, {
  Pagination,
  PaginationSelect,
  Hits,
  HitItemProps,
  NoHits
} from "searchkit";
import * as _ from "lodash";

// connect elasticsearch with searchkit

// set url - use a protected URL that only allows read actions
const ELASTICSEARCH_URL = 'https://shakestat-oregon-9345328632.us-west-2.bonsaisearch.net';
// initialize searchkit manager
const sk = new Searchkit.SearchkitManager(ELASTICSEARCH_URL, {});

const HitItem = (props) => (
  <div className={props.bemBlocks.item().mix(props.bemBlocks.container("item"))}>
    <a href={ props.result._source.url }>
      <div className={props.bemBlocks.item("title")} dangerouslySetInnerHTML={{__html:_.get(props.result,"highlight.title",false) || props.result._source.title}}></div>
    </a>
    <div><small className={props.bemBlocks.item("hightlights")} dangerouslySetInnerHTML={{__html:_.get(props.result,"highlight.text",'')}}></small></div>
  </div>
)

class Search extends Component {
  render(){
    const SearchkitProvider = Searchkit.SearchkitProvider;
    const Searchbox = Searchkit.SearchBox;

    var multiMatchOpts = {
      "multi_match" : {
      "operator":   "or"
      }
    }

    var queryOpts = {
      analyzer:"standard"
    }

    return (
      <div>
        <SearchkitProvider searchkit={sk}>
          <div className="search">
            <div className="search__query">
              <Searchbox searchOnChange={true}
                autoFocus={true}
                queryOptions={queryOpts}
                translations={{"searchbox.placeholder":"tomorrow and tomorrow and tomorrow", "NoHits.DidYouMean":"Search for {suggestion}."}}
                queryFields={["text", "title"]}/>
            </div>
            <div className="search__results">
              <Hits hitsPerPage={50}
                highlightFields={["title", "text"]}
                itemComponent={HitItem}/>
              <NoHits className="sk-hits" translations={{
                "NoHits.NoResultsFound":"No results were found for {query}",
                "NoHits.DidYouMean":"Search for {suggestion}"
              }} suggestionsField="text"/>
            </div>
         </div>
        </SearchkitProvider>
      </div>
    )
  }
}
export default Search;
