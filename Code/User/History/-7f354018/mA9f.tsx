import React from "react";
import { useGetSnapDataQuery } from "../services/api";
import { Spinner } from "@patternfly/react-core";
import { FailuresTable } from "../components/FailuresTable";

export const ResultsBlock: React.FunctionComponent = () => {
  function getData(selectedVersion: string, selectedSnap: string) {
    const { data, error, isLoading } =
      clusterApi.endpoints.getSnapData.useQuery([{ selectedVersion, vs }]);

    console.log(typeof selectedSnap);
    if (selectedVersion && selectedSnap) {
      if (error) {
        return "error";
      }
      if (isLoading) {
        return <Spinner aria-label="loading" />;
      }
      return <FailuresTable data={data2} />;
    } else {
      return <Spinner aria-label="loading" />;
    }
  }
};
