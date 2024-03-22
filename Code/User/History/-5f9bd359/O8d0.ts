import { createSlice, PayloadAction, createAsyncThunk } from "@reduxjs/toolkit";
import { clusterApi } from "./services/api";

export interface MainSlice {
  selectedVersion: string;
  selectedSnap: string;
  versions: Array<string>,
}

const initialState: MainSlice = {
  selectedVersion: "stream",
  selectedSnap: "",
  versions: [],
  //snaps
};

const fetchVersions = createAsyncThunk(
  '/versions',
  async (thunkAPI) => {
    const response = await clusterApi.getVersions()
    return response.data.versions
  },
)
)

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
  extraReducers: (builder) => {
    builder.addCase(fetchVersions.fulfilled, (state, action) => {
      state.versions = action.payload
    })
    /*
    builder.addMatcher(
      clusterApi.endpoints.getSnapsPerVersion.matchFulfilled,
      (state, { payload }) => {
        state.selectedSnap = payload.versions[0];
      }
    );
    */

  },
});

//get versions
//get snaps per version
//select default snap for version


export const { selectVersion, selectSnap } = mainSlice.actions;
export default mainSlice.reducer;
