import React from "react";
import { useGetSnapDataQuery } from "../services/api";
import { Spinner } from "@patternfly/react-core";
import { FailuresTable } from "../components/FailuresTable";
import { version } from "os";

type ResultsBlockProps = {
  version: string;
  snap: string;
};

export const ResultsBlock = ({ version, snap }: ResultsBlockProps): JSX.Element => {
    const { data, error, isLoading } = useGetSnapDataQuery({version, snap})

    if (version && snap) {
      if (error) {
        return <>"error"</>;
      }
      if (isLoading) {
        return <Spinner aria-label="loading" />;
      }
      return <FailuresTable data={data} />;
    } else {
      return <Spinner aria-label="loading" />;
    }
  }
};
