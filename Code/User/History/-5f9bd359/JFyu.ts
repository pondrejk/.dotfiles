import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { clusterApi } from "./services/api";

export interface MainSlice {
  versions: Array<string>;
  selectedVersion: string;
  selectedSnap: string;
}

const foundVersions = async function () {
  const [result = clusterApi.endpoints.getVersions.useLazyQuery();
  console.log(data);
  return data.versions;
};

const initialState: MainSlice = {
  versions: foundVersions(),
  selectedVersion: "stream",
  selectedSnap: "",
};

export const mainSlice = createSlice({
  name: "layout",
  initialState,
  reducers: {
    selectVersion: (state, action: PayloadAction<string>) => {
      const newSelectedVersion = action.payload;
      state.selectedVersion = newSelectedVersion;
      // state.selectedSnap = "";
    },
    selectSnap: (state, action: PayloadAction<string>) => {
      const newSelectedSnap = action.payload;
      state.selectedSnap = newSelectedSnap;
    },
  },
});

export const { selectVersion, selectSnap } = mainSlice.actions;
export default mainSlice.reducer;
