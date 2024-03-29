type t = PhysicalExamination__Form__Type.t
let toString = optionString => Js.Option.getWithDefault("", optionString)
let s = React.string
let systematic_examination_options = [
  "Not selected",
  "Cardiovascular",
  "Gastrointestinal",
  "Central nervous system",
  "Respiratory",
  "Genital-urinary",
]
@react.component
let make = (~data: t) => {
  <div>
    <div className="font-bold text-xl mb-5"> {s("Physical Examination")} </div>
    <div className="grid grid-cols-1 sm:grid-cols-6 lg:w-10/12">
      <NumberInput
        question="BP"
        field="bp"
        value={toString(data.bp)}
        minimum=None
        maximum=None
        divClass="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1"
        isRequired=false
      />
      <NumberInput
        question="GRBS"
        field="grbs"
        value={toString(data.grbs)}
        minimum=None
        maximum=None
        divClass="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1"
        isRequired=false
      />
      <NumberInput
        question="RR"
        field="rr"
        value={toString(data.rr)}
        minimum=None
        maximum=None
        divClass="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1"
        isRequired=false
      />
      <NumberInput
        question="Pulse"
        field="pulse"
        value={toString(data.pulse)}
        minimum=None
        maximum=None
        divClass="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1"
        isRequired=false
      />
      <TextInput
        question="Personal hygiene"
        field="personal_hygiene"
        defaultValue={toString(data.personal_hygiene)}
        form_id="patientvitals-form"
        divClass="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1"
        isRequired=false
      />
      <TextInput
        question="Mouth hygiene"
        field="mouth_hygiene"
        defaultValue={toString(data.mouth_hygiene)}
        form_id="patientvitals-form"
        divClass="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1"
        isRequired=false
      />
      <TextInput
        question="Public hygiene"
        field="pubic_hygiene"
        defaultValue={toString(data.pubic_hygiene)}
        form_id="patientvitals-form"
        divClass="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1"
        isRequired=false
      />
      <div className="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1">
        <label
          className="block text-sm font-medium
          text-gray-700">
          {s("Systematic examination")}
        </label>
        <div className="mt-1">
          <select
            name="systemic_examination"
            defaultValue={toString(data.systemic_examination)}
            required=true
            className="max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md">
            {systematic_examination_options
            ->Js.Array2.map(op => <option key=op value=op> {s(op)} </option>)
            ->React.array}
          </select>
        </div>
      </div>
      <div className="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1">
        <label className="block text-sm font-medium text-gray-700">
          {s("Systematic examination details")}
        </label>
        <div className="mt-1">
          <textarea
            type_="text"
            name="systemic_examination_details"
            defaultValue={toString(data.systemic_examination_details)}
            cols=50
            rows=1
            id="patientvitals-form"
            required=true
            className="shadow-sm
            focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-16"
          />
        </div>
      </div>
      <div className="sm:col-span-3 field my-2 lg:mx-10 sm:mx-1">
        <label className="block text-sm font-medium text-gray-700">
          {s("Visit done by(Doctor/Nurse/Volunteer/ASHA/Driver):")}
        </label>
        <div className="mt-1">
          <textarea
            type_="text"
            name="done_by"
            defaultValue={toString(data.done_by)}
            cols=50
            rows=1
            id="patientvitals-form"
            required=true
            className="shadow-sm
            focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md h-16"
          />
        </div>
      </div>
    </div>
    <div className="actions flex justify-center w-10/12">
      <input
        type_="submit"
        value="Save & Submit"
        className="mt-8 px-6 cursor-pointer inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      />
    </div>
  </div>
}
