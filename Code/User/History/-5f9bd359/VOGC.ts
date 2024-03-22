import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { clusterApi } from "./services/api";

export interface MainSlice {
  versions: Array<string>;
  selectedVersion: string;
  selectedSnap: string;
}

const initialState: MainSlice = {
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
    },
    selectSnap: (state, action: PayloadAction<string>) => {
      const newSelectedSnap = action.payload;
      state.selectedSnap = newSelectedSnap;
    },
  },
  /*
  extraReducers: (builder) => {
    builder.addMatcher(
      clusterApi.endpoints.getSnapsPerVersion.matchFulfilled,
      (state, { payload }) => {
        state.selectedSnap = payload.versions[0];
      }
    );
  */
  },
});

export const { selectVersion, selectSnap } = mainSlice.actions;
export default mainSlice.reducer;
