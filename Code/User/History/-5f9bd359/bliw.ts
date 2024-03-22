import { createSlice, PayloadAction, createAsyncThunk } from "@reduxjs/toolkit";
import { clusterApi } from "./services/api";
import { useAppDispatch } from "./app/hooks";

export interface MainSlice {
  selectedVersion: string;
  selectedSnap: string;
  versions: Array<string>;
}

const initialState: MainSlice = {
  selectedVersion: "stream",
  selectedSnap: "",
  versions: [],
  //snaps
};

export const fetchVersions = createAsyncThunk(
  "layout/versions",
  async (thunkAPI) => {
    const [versGet] = clusterApi.endpoints.getVersions.useLazyQuery();
    const response = await versGet().unwrap();
    return response.data.versions;
  }
);

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
  // Add reducers for additional action types here, and handle loading state as needed
  extraReducers: (builder) => {
    builder.addCase(fetchVersions.fulfilled, (state, action) => {
      console.log(action.payload);
      state.versions = action.payload;
    });
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
