let s = React.string

type option = {
  id: string,
  name: string,
  category: string,
}

type optionGroup = {
  categoryName: string,
  options: array<option>,
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

module DropDown = {
  @react.component
  let make = (~options, ~show, ~clickHandler) => {
    let categories = options->Belt.Array.map(option => {
      option.category
    })

    // Removing duplicates of the category names
    let categories = categories->Js.Array2.filteri((category, index) => {
      categories->Js.Array2.indexOf(category) == index
    })

    let optionGroups = categories->Belt.Array.map(category => {
      {
        categoryName: category,
        options: options->Js.Array2.filter(op => op.category == category),
      }
    })

    let optionGroups = optionGroups->Belt.Array.map(optionGroup => {
      <div key=optionGroup.categoryName className="bg-white">
        <div
          className="z-10 border-t border-b border-white sticky top-0 bg-indigo-600 px-6 py-5 text-base font-medium text-white flex">
          <h3> {s(optionGroup.categoryName)} </h3>
        </div>
        <div className="relative grid gap-8 px-5 py-8 sm:p-8 sm:gap-8">
          {optionGroup.options
          ->Belt.Array.map(option => {
            <button
              key=option.id
              className="-m-3 p-3 px-4 block rounded-md hover:bg-gray-100 transition ease-in-out duration-150"
              onClick={e => clickHandler(option.id, option.name)}>
              <p className="text-base font-medium text-gray-900 text-left"> {s(option.name)} </p>
            </button>
          })
          ->React.array}
        </div>
      </div>
    })

    if show {
      <div className="absolute z-10 left-1/2 transform -translate-x-1/2 mt-3 px-2 w-full sm:px-0">
        <div
          className="rounded-lg shadow-lg ring-1 ring-black ring-opacity-5 max-h-80 overflow-auto">
          <div className="relative grid bg-white"> {optionGroups->React.array} </div>
        </div>
      </div>
    } else {
      <div />
    }
  }
}

let decode = json => {
  open Json.Decode
  {
    id: field("id", string, json),
    name: field("name", string, json),
    category: field("category", string, json),
  }
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
