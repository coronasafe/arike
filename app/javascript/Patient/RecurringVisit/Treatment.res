// let s = React.string
// // to store the suggestions and their key(nanoid) together
// module Record = {
//   type t = {
//     id: string,
//     full_name: string,
//   }
//   let make = (id, word) => {
//     id: id,
//     full_name: word,
//   }
//   let id = t => t.id
//   let name = t => t.full_name
// }
// module Selectable = {
//   type rec t = Treatment(id, name)
//   and id = string
//   and name = string
//   let label = _t => None
//   let id = t =>
//     switch t {
//     | Treatment(id, _) => id
//     }
//   let value = t =>
//     switch t {
//     | Treatment(_, name) => name
//     }
//   let searchString = t => t->value
//   let color = _t => "gray"
//   let makeTreatment = (~id, ~name) => Treatment(id, name)
// }
// // create a Multiselect
// module Multiselect = MultiselectDropdown.Make(Selectable)
// type state = {
//   selected: array<Selectable.t>,
//   searchString: string,
// }

// // Bodhi: Use packs to load data. What happens if "Innertext" is not found?

// // JSON.parse
// // @scope("JSON") @val
// // external parseJson: string => array<Record.t> = "parse"

// let getJsonFromHtml = _dataElem => {
//   let _ = _dataElem->Belt.Array.map(ele => {
//     Selectable.makeTreatment(~id=ele[0], ~name=ele[1])
//   })
//   // let elem =
//   // Domutils.doc->Domutils.getElementById(dataElem)->Belt.Option.getWithDefault(Js.Obj.empty())

//   // elem["innerText"]
//   // ->Domutils.replaceAll("&quot;", "\"")
//   // ->parseJson
//   // ->Belt.Array.map(optionsInfo =>
//   //   Selectable.makeVolunteer(~id=optionsInfo->Record.id, ~name=optionsInfo->Record.name)
//   // )
//   []
// }

// @react.component
// let make = (~name, ~id, ~label, ~placeholder, ~dataElem) => {
//   let (state, setState) = React.useState(() => {searchString: "", selected: []})
//   let (unselected, setUnselected) = React.useState(() => getJsonFromHtml(dataElem))

//   // unselect components
//   let deselect = (selected, setState, selectable) => {
//     setUnselected(pv => pv->Belt.Array.concat([selectable]))
//     let newSelected = selected |> Js.Array.filter(s => s != selectable)
//     setState(_ => {searchString: "", selected: newSelected})
//   }

//   React.useEffect1(() => {
//     // filter sugguestion array so that one value can't be selected twice
//     let newArray = unselected->Js.Array2.filter(tmp => {
//       let optionElement =
//         state.selected->Js.Array2.find(elem => elem->Selectable.id == tmp->Selectable.id)
//       optionElement->Belt.Option.isNone
//     })

//     // new set of suggestions based on user input
//     setUnselected(_ => newArray)

//     None
//   }, [state])

//   <div>
//     <div>
//       <label
//         className="block text-sm font-medium text-gray-700"
//         htmlFor="MultiselectDropdown__search-input">
//         {label->s}
//       </label>
//     </div>
//     <Multiselect
//       id
//       name
//       unselected
//       selected={state.selected}
//       onSelect={selectable =>
//         setState(s => {
//           searchString: "",
//           selected: [selectable] |> Array.append(s.selected),
//         })}
//       onDeselect={deselect(state.selected, setState)}
//       value={state.searchString}
//       onChange={searchString => setState(s => {...s, searchString: searchString})}
//       hint=placeholder
//       defaultOptions=unselected
//     />
//   </div>
// }

let s = React.string
// to store the suggestions and their key(nanoid) together
module Record = {
  type t = {
    id: string,
    full_name: string,
  }
  let make = (id, word) => {
    id: id,
    full_name: word,
  }
  let id = t => t.id
  let name = t => t.full_name
}
module Selectable = {
  type rec t = Treatment(id, name)
  and id = string
  and name = string
  let label = _t => None
  let id = t =>
    switch t {
    | Treatment(id, _) => id
    }
  let value = t =>
    switch t {
    | Treatment(_, name) => name
    }
  let searchString = t => t->value
  let color = _t => "gray"
  let makeTreatment = (~id, ~name) => Treatment(id, name)
}
// create a Multiselect
module Multiselect = MultiselectDropdown.Make(Selectable)
type state = {
  selected: array<Selectable.t>,
  searchString: string,
}
let unselected = [
  Selectable.makeTreatment(~id="1", ~name="Delhi"),
  Selectable.makeTreatment(~id="2", ~name="India"),
  Selectable.makeTreatment(~id="3", ~name="Washington D.C"),
  Selectable.makeTreatment(~id="4", ~name="USA"),
]
let select = (setState, selectable) => {
  setState(s => {
    let selected = if Js.Array.includes(selectable, s.selected) {
      s.selected
    } else {
      Belt.Array.concat(s.selected, [selectable])
    }

    {
      searchString: "",
      selected: s.selected,
    }
  })
}
let deselect = (selected, setState, selectable) => {
  let newSelected = selected |> Js.Array.filter(s => s != selectable)
  setState(_ => {searchString: "", selected: newSelected})
}
let updateSearchInput = (setState, searchInput) => setState(s => {...s, searchString: searchInput})
@react.component
let make = (~name, ~id, ~label, ~placeholder) => {
  let (state, setState) = React.useState(() => {searchString: "", selected: []})
  React.useEffect1(() => {
    // filter sugguestion array so that one value can't be selected twice
    let _ = unselected->Js.Array2.filter(tmp => {
      let optionElement =
        state.selected->Js.Array2.find(elem => elem->Selectable.id == tmp->Selectable.id)
      optionElement->Belt.Option.isNone
    })
    None
  }, [state])
  <div>
    <div>
      <label
        className="block text-sm font-medium text-gray-700"
        htmlFor="MultiselectDropdown__search-input">
        {label->s}
      </label>
    </div>
    <Multiselect
      id
      name
      unselected={unselected}
      selected={state.selected}
      onSelect={select(setState)}
      onDeselect={deselect(state.selected, setState)}
      value={state.searchString}
      onChange={updateSearchInput(setState)}
      hint=placeholder
      defaultOptions={unselected}
    />
  </div>
}
