import { configureStore, ThunkAction, Action } from "@reduxjs/toolkit";
import mainReducer from "../MainSlice";
import {import { setupListeners } from '@reduxjs/toolkit/query'
import { pokemonApi } from './services/pokemon'
import { clusterApi } from "../services/api";

export const store = configureStore({
  reducer: {
    // Add the generated reducer as a specific top-level slice
  },
  // Adding the api middleware enables caching, invalidation, polling,
  // and other useful features of `rtk-query`.
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware().concat(pokemonApi.middleware),
})

// optional, but required for refetchOnFocus/refetchOnReconnect behaviors
// see `setupListeners` docs - takes an optional callback as the 2nd arg for customization
setupListeners(store.dispatch) clusterApi } from "../services/api";}

export const store = configureStore({
  reducer: {
    main: mainReducer,
    [clusterApi.reducerPath]: clusterApi.reducer,
  },
  // Adding the api middleware enables caching, invalidation, polling,
  // and other useful features of `rtk-query`.
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware().concat(pokemonApi.middleware),
});




export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;
