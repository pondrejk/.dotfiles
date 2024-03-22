// Need to use the React-specific entry point to import createApi
import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
//import type { Pokemon } from './types'

// Define a service using a base URL and expected endpoints
export const clusterApi = createApi({
  reducerPath: "clusterApi",
  baseQuery: fetchBaseQuery({ baseUrl: import.meta.env.VITE_API_URL }),
  endpoints: (builder) => ({
    getVersions: builder.query({
      query: () => `/versions`,
    }),
    getSnapsPerVersion: builder.query({
      query: (version) => `/snaps/${version}`,
    }),
    getSnapData: builder.query({
      query: (version: string, snap: string) => `/snaps/${version}/${snap}`,
    }),
  }),
});

// Export hooks for usage in functional components, which are
// auto-generated based on the defined endpoints -- use<endpoint>Query
export const { useGetVersionsQuery } = clusterApi;
