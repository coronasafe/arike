type t = PsychologicalReview__Form__Type.t
let s = React.string
let toString = optionString => Js.Option.getWithDefault("", optionString)
let general_options = [
  "Not selected",
  "Not at all",
  "Slightly",
  "Moderately",
  "Severely",
  "Overwhelmingly",
  "Cannot assess",
]

@react.component
let make = (~data: t) => {
  let general_questions = [
    (
      "Is the patient feeling worried about illness/treatment?",
      "patient_worried",
      true,
      data.patient_worried,
    ),
    ("Is patient depressed?", "patient_depressed", true, data.patient_depressed),
    (
      "Does family/friends feel anxious about patient's illness/treatment?",
      "family_anxious",
      true,
      data.family_anxious,
    ),
    (
      "Has the patient been able to share his feelings with his family/friends?",
      "patient_feels",
      true,
      data.patient_feels,
    ),
    (
      "Has the patient had as much information as he wanted?",
      "patient_informed",
      true,
      data.patient_informed,
    ),
  ]
  <div>
    <div className="font-bold text-xl mb-5"> {s("Psychological Review")} </div>
    <div className="grid lg:grid-cols-2 lg:pl-10 lg:w-10/12 lg:pr-5">
      {general_questions
      ->Belt.Array.map(((ques, field, required, value)) =>
        <DropDownInput
          value={toString(value)}
          question=ques
          field
          options=general_options
          isRequired=required
          key=field
        />
      )
      ->React.array}
    </div>
    <div className="actions flex justify-center w-10/12">
      <input
        type_="submit"
        value="Save & Next"
        className="mt-4 px-6 cursor-pointer inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      />
    </div>
  </div>
}
