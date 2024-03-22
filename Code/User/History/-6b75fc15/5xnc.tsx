import { configureStore, ThunkAction, Action } from "@reduxjs/toolkit";
import mainReducer, { fetchVersions } from "../MainSlice";
import { clusterApi } from "../services/api";

//import { setupListeners } from "@reduxjs/toolkit/query";

export const store = configureStore({
  reducer: {
    main: mainReducer,
    [clusterApi.reducerPath]: clusterApi.reducer,
  },
  // Adding the api middleware enables caching, invalidation, polling,
  // and other useful features of `rtk-query`.
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware().concat(clusterApi.middleware),
});

// optional, but required for refetchOnFocus/refetchOnReconnect behaviors
// see `setupListeners` docs - takes an optional callback as the 2nd arg for customization
//setupListeners(store.dispatch);

store.dispatch(clusterApi.endpoints.getVersions.initiate());

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;
