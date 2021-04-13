let s = React.string

type option = {
  id: string,
  name: string,
  category: string,
}

let onWindowClick = (showDropdown, setShowDropdown, _event) =>
  if showDropdown {
    setShowDropdown(_ => false)
  } else {
    ()
  }

let search = (searchString, options) => {
  (options |> Js.Array.filter(option =>
    option.name
    |> String.lowercase_ascii
    |> Js.String.includes(searchString |> String.lowercase_ascii)
  ))->Belt.SortArray.stableSortBy((x, y) => String.compare(x.name, y.name))
}

type optionGroup = {
  categoryName: string,
  options: array<option>,
}

module DropDown = {
  @react.component
  let make = (~options, ~show, ~clickHandler) => {
    let categoryList = []
    options->Belt.Array.forEach(op => {
      if !Js.Array2.includes(categoryList, op.category) {
        Js.Array2.push(categoryList, op.category)->ignore
      }
    })
    let optionGroupList = categoryList->Belt.Array.map(el => {
      {
        categoryName: el,
        options: options->Js.Array2.filter(e => e.category == el),
      }
    })
    Js.log(optionGroupList)
    let options = optionGroupList->Belt.Array.map(option => {
      <div className="relative grid  bg-white px-5 py-6 sm:gap-8 sm:p-8">
        <p className="text-lg font-bold  text-gray-900 mb-1 text-left">
          {s(option.categoryName)}
          <span className="text-base ml-2">
            {s("(" ++ Belt.Int.toString(Js.Array2.length(option.options)) ++ ")")}
          </span>
        </p>
        {option.options
        ->Belt.Array.map(el => {
          <button
            key=el.id
            className="-m-3 p-3 block rounded-md hover:bg-gray-100 transition ease-in-out duration-150"
            onClick={e => clickHandler(el.id, el.name)}>
            <p className="text-base font-medium text-gray-900 text-left"> {s(el.name)} </p>
          </button>
        })
        ->React.array}
      </div>
    })

    if show {
      <div className="absolute z-10 left-1/2 transform -translate-x-1/2 mt-3 px-2 w-full sm:px-0">
        <div
          className="rounded-lg shadow-lg ring-1 ring-black ring-opacity-5 max-h-80 overflow-auto">
          <div className="relative grid bg-white "> {options->React.array} </div>
        </div>
      </div>
    } else {
      <div />
    }
  }
}

let decode = json => {
  open Json.Decode
  let item = {
    id: field("id", string, json),
    name: field("name", string, json),
    category: field("category", string, json),
  }
  item
}

@react.component
let make = (~id, ~className, ~placeholder, ~label, ~optionClickHandler, ~api) => {
  let (options, setOptions) = React.useState(() => [])
  let (showDropdown, setShowDropdown) = React.useState(() => false)
  let (searchResults, setSearchResults) = React.useState(() => [])

  React.useEffect0(() => {
    // Fetch the data([{id: string, name: string}]) from the provided api
    open Js.Promise
    Fetch.fetch(api)
    |> then_(Fetch.Response.json)
    |> then_(json => Js.Json.decodeArray(json) |> resolve)
    |> then_(opt => opt->Belt.Option.getWithDefault([Js.Json.null]) |> resolve)
    |> then_(items => {
      let items = items->Belt.Array.map(item => item->decode)
      setOptions(_ => items)
      items |> resolve
    })
    |> ignore

    None
  })

  React.useEffect1(() => {
    let curriedFunction = onWindowClick(showDropdown, setShowDropdown)

    let removeEventListener = () =>
      Webapi.Dom.Window.removeEventListener("click", curriedFunction, Webapi.Dom.window)

    if showDropdown {
      Webapi.Dom.Window.addEventListener("click", curriedFunction, Webapi.Dom.window)
      Some(removeEventListener)
    } else {
      removeEventListener()
      None
    }
  }, [showDropdown])

  React.useEffect1(() => {
    setSearchResults(_ => options)
    None
  }, [options])

  <div className id>
    <label className="block text-lg font-medium text-gray-700"> {s(label)} </label>
    <div className="relative mt-1 w-full">
      <input
        className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
        type_="text"
        placeholder
        onClick={_ => setShowDropdown(_ => true)}
        onChange={e => {
          let value = ReactEvent.Form.target(e)["value"]
          setSearchResults(_ => search(value, options))
        }}
      />
      <DropDown options=searchResults show=showDropdown clickHandler=optionClickHandler />
    </div>
  </div>
}
